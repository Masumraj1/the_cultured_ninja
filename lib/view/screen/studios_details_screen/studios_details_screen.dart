
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudiosDetailsScreen extends StatelessWidget {
  StudiosDetailsScreen({super.key});

  final CustomWidgets customWidget = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=========================Studio Image======================
              CustomNetworkImage(
                  borderRadius: BorderRadius.circular(14),
                  imageUrl: AppConstants.disneyPlus,
                  height: 241.h,
                  width: double.infinity),
              SizedBox(
                height: 14.h,
              ),

              ///=========================Follow button======================
              CustomButton(
                onTap: () {},
                title: AppStrings.following,
                fillColor: AppColors.lightWhite,
                textColor: AppColors.buttonColor,
              ),
              CustomText(
                top: 26,
                textAlign: TextAlign.start,
                text: AppStrings.warnerBros,
                fontSize: 18.sp,
                maxLines: 6,
                fontWeight: FontWeight.w500,
                color: AppColors.lightWhite,
              ),
              CustomText(
                top: 16,
                text: AppStrings.synopsis,
                fontSize: 16.sp,
                bottom: 8,
                fontWeight: FontWeight.w500,
                color: AppColors.lightWhite,
              ),
              CustomText(
                textAlign: TextAlign.start,
                text: AppStrings.weAreDedicated,
                fontSize: 12.sp,
                maxLines: 5,
                bottom: 24,
                fontWeight: FontWeight.w400,
                color: AppColors.lightWhite,
              ),

              ///====================================latest updates==============
              CustomText(
                textAlign: TextAlign.start,
                text: AppStrings.latestUpdates,
                fontSize: 18.sp,
                bottom: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.lightWhite,
              ),

              ///==================================related Studios====================
             customWidget.customRow(
                  startTitle: AppStrings.relatedStudios,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    Get.toNamed(AppRoute.studiosScreen);
                  }),

              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 170.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return customWidget.customImageText(
                          image: AppConstants.movieStudio,
                          movieName: "Universal Studios");
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
