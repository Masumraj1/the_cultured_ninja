import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
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
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController calendarController = Get.find<CalendarController>();

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

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  ///=============================Calender==============
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
                        controlsTextStyle:
                            const TextStyle(color: AppColors.lightWhite),
                        dayTextStyle:
                            const TextStyle(color: AppColors.lightWhite),
                        monthTextStyle:
                            const TextStyle(color: AppColors.lightWhite),
                        yearTextStyle:
                            const TextStyle(color: AppColors.lightWhite),
                        weekdayLabelTextStyle:
                            const TextStyle(color: AppColors.lightWhite),
                        selectedDayHighlightColor: AppColors.buttonColor,
                      ),
                      value: scheduleDates,
                    ),
                  ),
                  Column(
                    children: List.generate(movies.length, (index) {
                      var data = movies[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: CustomFavoriteWidget(
                          image: data.poster ?? "",
                          movieName: data.title ?? "",
                          releaseDate: DateConverter.formatDate(
                              data.calenderedFor ?? "22"),
                          isExpanded: true,
                          onTap: () {
                            if (scheduleDates.isNotEmpty) {
                              showCustomDeleteDialog(
                                context,
                                () {
                                  final selectedDate = scheduleDates.firstWhere(
                                      (date) => date != null,
                                      orElse: () => DateTime.now());
                                  final selectedDateString =
                                      DateFormat('dd-MM-yyyy').format(
                                          selectedDate ?? DateTime.now());

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
                          date: DateConverter.formatDate(
                              data.calenderedFor ?? "22"),
                        ),
                      );
                    }),
                  )
                ],
              ),
            );
        }
      }),
    );
  }
}
