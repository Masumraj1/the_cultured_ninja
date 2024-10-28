import 'dart:developer';

import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/controller/movie_details_controller/movie_details_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/google_sign_in_service.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/model/actor_details_model/actor_details_model.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_image_text/custom_image_text.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:shared_preferences/shared_preferences.dart';

class ActorDetails extends StatefulWidget {
  const ActorDetails({super.key});

  @override
  State<ActorDetails> createState() => _ActorDetailsState();
}

class _ActorDetailsState extends State<ActorDetails> {
 ///=============================Calendar=========================
  final CustomWidgets customWidget = CustomWidgets();
  final MovieDetailsController movieDetailsController = Get.find<MovieDetailsController>();
  final CalendarController calendarController = Get.find<CalendarController>();

  final String id = Get.arguments.toString();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieDetailsController.actorDetail(id: id);
    });
  }

  /// Google Sign-In Method
  Future<http.Client?> googleSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('signedInEmail');

    if (savedEmail != null) {
      log("================User already signed in with email:============ $savedEmail");
      return await _getAuthenticatedClient();
    } else {
      try {
        final user = await GoogleSignInService.login();
        final GoogleSignInAuthentication? googleAuth = await user?.authentication;

        log('User: ${user!.displayName}, Email: ${user.email}');
        final httpClient = await obtainAuthenticatedClient(googleAuth!);

        if (httpClient != null) {
          log("=============Successfully authenticated==================");
          await prefs.setString('signedInEmail', user.email);
          return httpClient;
        }
      } catch (exception) {
        log('====================Error during Google Sign-In:============== ${exception.toString()}');
      }
    }
    return null;
  }

  /// Obtain authenticated HTTP client for existing sign-ins
  Future<http.Client?> _getAuthenticatedClient() async {
    final user = await GoogleSignInService.getCurrentUser();
    if (user != null) {
      final googleAuth = await user.authentication;
      return await obtainAuthenticatedClient(googleAuth);
    }
    return null;
  }

  /// Obtain authenticated HTTP client
  Future<http.Client?> obtainAuthenticatedClient(GoogleSignInAuthentication googleAuth) async {
    try {
      return authenticatedClient(
        http.Client(),
        AccessCredentials(
          AccessToken(
            'Bearer',
            googleAuth.accessToken!,
            DateTime.now().toUtc().add(const Duration(hours: 1)),
          ),
          null,
          ['https://www.googleapis.com/auth/calendar'],
        ),
      );
    } catch (e) {
      log('=================Failed to obtain an authenticated client:============= $e');
      return null;
    }
  }

  /// Add Event to Google Calendar
  Future<void> addEventToGoogleCalendar(http.Client client, String eventTitle, DateTime eventDate) async {
    try {
      var calendarApi = calendar.CalendarApi(client);
      final eventStart = eventDate.toUtc();
      final eventEnd = eventStart.add(const Duration(hours: 1));

      var event = calendar.Event()
        ..summary = eventTitle
        ..description = 'Event created from Flutter app'
        ..start = calendar.EventDateTime(dateTime: eventStart)
        ..end = calendar.EventDateTime(dateTime: eventEnd);

      final insertedEvent = await calendarApi.events.insert(event, 'primary');
      log('===========Event added to calendar with ID:=========== ${insertedEvent.id}');

    } catch (e) {
      log('===============Error adding event:============ $e');
    }
  }

  /// Show Dialog Box for Date Selection and Event Addition
  void showDialogBox(BuildContext context, String actorId, String actorName) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        content: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Closes the dialog
                    },
                    child: const CustomImage(
                      imageSrc: AppIcons.x,
                      imageType: ImageType.svg,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                textEditingController: TextEditingController(
                  text: calendarController.selectedDate.value.toString(),
                ),
                fillColor: AppColors.lightWhite,
                fieldBorderColor: AppColors.fromRgb,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: const Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 15.h),
              Obx(() => calendarController.isAdded.value
                  ? const CustomLoader()
                  : CustomButton(
                onTap: () async {
                  final httpClient = await googleSignIn();
                  if (httpClient != null) {
                    await addEventToGoogleCalendar(
                      httpClient,
                      actorName,
                      calendarController.selectedDate.value,
                    );
                    calendarController.addedCalender(
                        id: actorId,
                        date: DateConverter.calender(calendarController.selectedDate.value));
                  }
                  Get.back(); // Close the dialog after adding
                },
                fillColor: AppColors.buttonColor,
                title: 'Add to Calendar',
              )),
            ],
          );
        }),
      ),
    );
  }

  /// Date Picker for Selecting Event Date
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: calendarController.selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Update the selected date in the controller
      calendarController.selectedDate.value = picked;
    }
  }
  ///================================Calender============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///===========================Actor details appbar=============================
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
          text: AppStrings.actorDetails,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        var data = movieDetailsController.actorDetails.value;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.fromRgb,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.borderRgb),
                  ),
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        boxShape: BoxShape.circle,
                        imageUrl: data.profilePath ?? "",
                        height: 97,
                        width: 142,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            text: data.name ?? "",
                            color: AppColors.lightWhite,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            bottom: 7,
                          ),
                          Obx(
                                () => GestureDetector(
                              onTap: () {
                                movieDetailsController.toggleActorFlow(id);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 40.h,
                                width: 114.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.blackDeep,
                                ),
                                child: Row(
                                  children: [
                                    CustomImage(
                                      imageSrc: movieDetailsController.isFollowed.value
                                          ? AppIcons.unFollow
                                          : AppIcons.profileSelected,
                                    ),
                                    CustomText(
                                      left: 10,
                                      text: movieDetailsController.isFollowed.value
                                          ? AppStrings.unfollow
                                          : AppStrings.follow,
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///===================================Upcoming movies====================
                customWidget.customRow(
                  startTitle: AppStrings.upcomingMovie,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    List<Movie> upcomingMovies = data.upcomingMovies ?? [];
                    Get.toNamed(AppRoute.actorMovie, arguments: upcomingMovies);
                  },
                ),
                SizedBox(height: 16.h),

                data.upcomingMovies == null || data.upcomingMovies!.isEmpty
                    ? SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: CustomText(
                      text: 'No Upcoming Movies',
                      color: AppColors.lightWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                    : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.upcomingMovies?.length ?? 0,
                    itemBuilder: (context, index) {
                      var upcomingData = data.upcomingMovies?[index];
                      return customWidget.customUpcomingMovies(
                        onTap: () {
                          showDialogBox(context, upcomingData?.id.toString() ?? "", upcomingData?.title ?? "Movie Event");
                        },
                        image: upcomingData?.posterPath ?? "",
                        movieName: upcomingData?.title ?? "",
                        releaseDate: upcomingData?.releaseDate.toString() ?? "",
                        button: AppStrings.addToCalender,
                      );
                    },
                  ),
                ),

                ///=========================His work=========================
                customWidget.customRow(
                  startTitle: AppStrings.hisWork,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    List<Movie> popularWork = data.popularMovies ?? [];
                    Get.toNamed(AppRoute.actorMovie, arguments: popularWork);
                  },
                ),
                SizedBox(height: 16.h),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      data.popularMovies?.length ?? 0,
                          (index) {
                        var popularData = data.popularMovies?[index];
                        return CustomImageText(
                          image: popularData?.posterPath ?? "",
                          movieName: popularData?.title ?? "",
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

}
