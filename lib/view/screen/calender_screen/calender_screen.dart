import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/google_sign_in_service.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_delete_dialoge/custom_delete_dialoge.dart';
import 'package:final_movie/view/widgets/custom_favorite_widget/custom_favorite_widget.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/calendar/v3.dart' as calendar;

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController calendarController = Get.find<CalendarController>();
  bool isAuthorized = false; // Track if the user has allowed access

  // Simulate permission request for accessing Google Calendar
  Future<void> _requestCalendarPermission() async {
    // Placeholder for actual Google Calendar permission code.
    setState(() {
      isAuthorized = true; // Simulate permission granted
    });
  }

  /// Google Sign-In Method
  Future googleSignIn() async {
    try {
      // Sign in using Google Sign-In service
      final user = await GoogleSignInService.login();

      // Retrieve authentication tokens after login
      final GoogleSignInAuthentication? googleAuth = await user?.authentication;

      log('==========User Name:=========== ${user!.displayName}');
      log('=============User Email:========== ${user.email}');
      log('============Access Token:============= ${googleAuth?.accessToken}');
      log('=============ID Token:============== ${googleAuth?.idToken}');

      // Get an authenticated client for making API requests
      final httpClient = await obtainAuthenticatedClient(googleAuth!);
      if (httpClient != null) {
        log("==================Successfully authenticated=================");
        await addEventToGoogleCalendar(httpClient); // Add event to Google Calendar
      }
    } catch (exception) {
      log(exception.toString()); // Log any errors that occur during login
    }
  }

  /// Obtains an authenticated HTTP client for API requests
  Future<http.Client?> obtainAuthenticatedClient(
      GoogleSignInAuthentication googleAuth) async {
    try {
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
            AccessToken(
              'Bearer',
              googleAuth.accessToken!, // Use the access token from Google Sign-In
              DateTime.now().toUtc().add(const Duration(hours: 1)), // Convert time to UTC
            ),
            null,
            ['https://www.googleapis.com/auth/calendar'], // Scope for accessing Google Calendar
          ));
    } catch (e) {
      log('Failed to obtain an authenticated client: $e');
      return null;
    }
  }

  /// Function to add an event to Google Calendar
  Future<void> addEventToGoogleCalendar(http.Client client) async {
    try {
      var calendarApi = calendar.CalendarApi(client);

      // Define start and end time of the event
      final now = DateTime.now();
      final eventStart = now.add(const Duration(minutes: 1)).toUtc(); // Event starts 1 minute from now
      final eventEnd = now.add(const Duration(hours: 1)).toUtc(); // Event ends after 1 hour

      // Create the event details
      var event = calendar.Event()
        ..summary = 'Flutter Calendar Event'
        ..description = 'Testing event creation from Flutter app'
        ..start = calendar.EventDateTime(dateTime: eventStart)
        ..end = calendar.EventDateTime(dateTime: eventEnd);

      // Insert the event into the calendar
      final insertedEvent = await calendarApi.events.insert(event, 'primary');
      log('Event added to calendar with ID: ${insertedEvent.id}');

      // Show a confirmation message using SnackBar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Event successfully added! Start: ${eventStart.toLocal()} \nEnd: ${eventEnd.toLocal()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      log('Error adding event: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add event to Google Calendar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const NavBar(currentIndex: 2),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: Text(
          AppStrings.calendar,
          style: TextStyle(
            color: AppColors.lightWhite,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        switch (calendarController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(
              onTap: () {
                calendarController.getCalender();
              },
            );
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                calendarController.getCalender();
              },
            );
          case Status.completed:
            final movies = calendarController.calenderModel.value.movies;
            if (movies == null || movies.isEmpty) {
              return const Center(
                child: Text(
                  'No movies available in Calender',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            List<DateTime?> scheduleDates = movies.map((dateData) {
              return DateTime.tryParse(dateData.calenderedFor.toString());
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    isAuthorized
                        ? 'Access granted! You can now view upcoming movie events in Google Calendar.'
                        : 'To view upcoming movie events in your Google Calendar, please allow access.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: AppColors.lightWhite),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: googleSignIn,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Allow Google Calendar Access'),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.fromRgb,
                    border: Border.all(color: AppColors.borderDrawer),
                  ),
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.multi,
                      controlsTextStyle: const TextStyle(color: AppColors.lightWhite),
                      dayTextStyle: const TextStyle(color: AppColors.lightWhite),
                      monthTextStyle: const TextStyle(color: AppColors.lightWhite),
                      yearTextStyle: const TextStyle(color: AppColors.lightWhite),
                      weekdayLabelTextStyle: const TextStyle(color: AppColors.lightWhite),
                      selectedDayHighlightColor: AppColors.buttonColor,
                    ),
                    value: scheduleDates,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      var data = movies[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: CustomFavoriteWidget(
                          image: data.poster ?? "",
                          movieName: data.title ?? "",
                          releaseDate: DateConverter.formatDate(data.calenderedFor ?? "22"),
                          isExpanded: true,
                          onTap: () {
                            if (scheduleDates.isNotEmpty) {
                              showCustomDeleteDialog(
                                context,
                                    () {
                                  final selectedDate = scheduleDates.firstWhere(
                                          (date) => date != null,
                                      orElse: () => DateTime.now());
                                  final selectedDateString = DateFormat('dd-MM-yyyy')
                                      .format(selectedDate ?? DateTime.now());

                                  calendarController.addedCalender(
                                    id: data.movieId.toString(),
                                    date: selectedDateString,
                                  );
                                },
                              );
                            } else {
                              log('No dates available to add to the calendar.');
                            }
                          },
                          date: DateConverter.formatDate(data.calenderedFor ?? "22"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}
