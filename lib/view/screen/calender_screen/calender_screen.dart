import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  final CustomWidgets customWidget = CustomWidgets();
  final CalendarController calendarController = Get.find<CalendarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const NavBar(currentIndex: 2),

      ///=================================calendar appbar===================
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
          text: AppStrings.calendar,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
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

          // Convert the date values to DateTime objects
            List<DateTime?> scheduleDates = calendarController.calenderModel.value.dates
                ?.map((dateData) {
              // Convert string month to integer month
              int month = _getMonthFromString(dateData.month?.toString() ?? "");
              return DateTime(dateData.year ?? 0, month, dateData.date ?? 1);
            })
                .toList() ?? [];

            // Log the total count of dates
            print('Total Dates to be displayed:========================= ${scheduleDates.length}');
            print('Total Dates to be First:========================= ${scheduleDates.first}');
            print('Total Dates to be Last:========================= ${scheduleDates.last}');

            return Column(
              children: [
                ///===============================This is calendar==================
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
                    value: scheduleDates, // Pass the list of DateTime objects
                  ),
                ),

                ///==========================movie list====================
                Expanded(
                  child: ListView.builder(
                    itemCount: calendarController.calenderModel.value.movies?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = calendarController.calenderModel.value.movies?[index];
                      return customWidget.customMovie(
                        image: data?.poster ?? "",
                        movieName: data?.title ?? "",
                        releaseDate: DateConverter.formatDate(data?.calenderedFor),
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

  // Helper method to convert month names to integer values
  int _getMonthFromString(String monthName) {
    switch (monthName.toLowerCase()) {
      case "january":
        return 1;
      case "february":
        return 2;
      case "march":
        return 3;
      case "april":
        return 4;
      case "may":
        return 5;
      case "june":
        return 6;
      case "july":
        return 7;
      case "august":
        return 8;
      case "september":
        return 9;
      case "october":
        return 10;
      case "november":
        return 11;
      case "december":
        return 12;
      default:
        return 1; // Default to January if no valid match
    }
  }
}
