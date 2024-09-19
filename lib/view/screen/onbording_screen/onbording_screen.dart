


import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_movie/controller/onbording_controller/onbording_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  final OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///=========================================Background Image=========================
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AppImages.background),
              ),
            ),
          ),
          ///=================================== Welcome Text===========================
          Positioned(
            top: 134.h,
            left: 47.w,
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: AppStrings.welcomeTo,
                    style: TextStyle(
                      color: AppColors.lightWhite,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                    ),
                  ),
                  TextSpan(
                    text: AppStrings.screenDelights,
                    style: TextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ///=============================================== image===================
          Positioned.fill(
            left: 20,
            right: 20,
            child: Obx(() {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      controller.currentIndex.value == 0
                          ? AppImages.onBoardingOne
                          : controller.currentIndex.value == 1
                          ? AppImages.onBoardingTwo
                          : AppImages.onBoardingThree,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (value) {
                          controller.changePage(value);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.titleFirstPart.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 32.sp,
                                        color: AppColors.buttonColor,
                                        text: "Hi",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Subtitle
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: CustomText(
                                  top: 8.h,
                                  maxLines: 3,
                                  text: controller.titleFirstPart[index],
                                  fontSize: 16.sp,
                                  color: AppColors.lightWhite,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 64.h),
                    // Dots Indicator
                    DotsIndicator(
                      dotsCount: controller.titleFirstPart.length,
                      position: controller.currentIndex.value,
                      decorator: const DotsDecorator(
                        color: AppColors.lightWhite,
                        activeColor: AppColors.buttonColor,
                        activeSize: Size(12.0, 12.0),
                        size: Size.square(12),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ///========================================== Get Started Button========================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
                      child: CustomButton(
                        fillColor: AppColors.buttonColor,
                        title: AppStrings.getStared,
                        onTap: () {
                          Get.toNamed(AppRoute.signInScreen);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
