import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuccessfullyScreen extends StatelessWidget {
  const SuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///=============================BackGround Image========================
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImages.background,
                ),
              ),
            ),
          ),

          Positioned(
              top: 44,
              left: 20,
              child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back,color: Colors.white,))),
          Positioned(
            top: 134,
            left: 0,
            right: 0,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  ///===============================forget Password=====================
                  CustomText(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    text: AppStrings.successfully,
                    color: AppColors.lightWhite,
                    bottom: 12,
                  ), CustomText(
                    fontSize: 14.sp,
                    maxLines: 3,
                    fontWeight: FontWeight.w400,
                    text: AppStrings.yourPasswordHasBeenUpdated,
                    color: AppColors.normalWhite,
                    bottom: 215,
                  ),

                  ///======================================send A code Button==================
                  CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoute.signInScreen);
                    },
                    title: AppStrings.continues,
                    fillColor: AppColors.buttonColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
