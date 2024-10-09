import 'package:final_movie/controller/studios_controller/studios_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image_text/custom_image_text.dart';
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

  final img = Get.arguments[0];
  final name = Get.arguments[1];
  final totalMovie = Get.arguments[2];

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
                    imageUrl: "${ApiUrl.networkImageUrl}$img",
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
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      textAlign: TextAlign.start,
                      text: 'Studio Name :',
                      fontSize: 18,
                      maxLines: 6,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                    ),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: name,
                      fontSize: 15,
                      maxLines: 6,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                    ),
                  ],
                ),

                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      textAlign: TextAlign.start,
                      text: 'Total Movie :',
                      fontSize: 18,
                      maxLines: 6,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                    ),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: totalMovie.toString(),
                      fontSize: 15,
                      maxLines: 6,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
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
                        return CustomImageText(
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
