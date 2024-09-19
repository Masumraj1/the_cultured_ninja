import 'package:final_movie/controller/studios_controller/studios_controller.dart';
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
  final StudiosController studiosController = Get.find<StudiosController>();

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
          child: Obx(() {
            return Column(
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

                studiosController.isTap.value
                    ? CustomButton(
                        onTap: () {
                          studiosController.toggleTap();
                        },
                        title: AppStrings.follow,
                        fillColor: AppColors.lightWhite,
                        textColor: AppColors.buttonColor,
                      )
                    : CustomButton(
                        onTap: () {
                          studiosController.toggleTap();
                        },
                        title: AppStrings.following,
                        fillColor: AppColors.buttonColor,
                        textColor: AppColors.lightWhite,
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

                Column(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h), // Adds space between each Row
                      child: Row(
                        children: [
                          CustomNetworkImage(
                            borderRadius: BorderRadius.circular(8),
                            imageUrl: AppConstants.movieImage,
                            height: 50,
                            width: 78,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          const CustomText(
                            text: "Now showing this movie",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: AppColors.lightWhite,
                          ),
                        ],
                      ),
                    );
                  }),
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
            );
          }),
        ),
      ),
    );
  }
}
