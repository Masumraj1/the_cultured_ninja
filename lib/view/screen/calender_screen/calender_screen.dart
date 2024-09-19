import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  final CustomWidgets customWidget = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.find<CalendarController>();

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
        return Column(
          children: [
            ///===============================This is calendar==================
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.fromRgb,
                  border: Border.all(color: AppColors.borderDrawer)),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  // daySplashColor: AppColors.buttonColor,
                  controlsTextStyle:
                      const TextStyle(color: AppColors.lightWhite),
                  dayTextStyle: const TextStyle(color: AppColors.lightWhite),
                  monthTextStyle: const TextStyle(color: AppColors.lightWhite),
                  yearTextStyle: const TextStyle(color: AppColors.lightWhite),
                  weekdayLabelTextStyle:
                      const TextStyle(color: AppColors.lightWhite),
                  selectedDayHighlightColor: AppColors.buttonColor,
                ),
                value: controller.dates,
                onValueChanged: (dates) {
                  controller.updateDates(dates);
                },
              ),
            ),


        ///==========================movie list====================
        Expanded(
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context,index){
            return   SingleChildScrollView(
              child: customWidget.customMovie(
                  image: AppConstants.movieImage,
                  movieName: "the stupid",
                  releaseDate: "10 august ",
                  year: '2022'),
            );
          }),
        )


          ],
        );
      }),
    );
  }
}
