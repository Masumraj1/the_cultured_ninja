import 'package:final_movie/controller/authentication_controller/authentication_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final formKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController =
  Get.find<AuthenticationController>();

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

          ///=============================Back Button==============================
          Positioned(
            top: 44,
            left: 20,
            child: InkWell(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),

          ///=============================Form==============================
          Positioned(
            top: 134,
            left: 0,
            right: 0,
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ///===============================Set New Password=====================
                      CustomText(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        text: AppStrings.setANewPassword,
                        color: AppColors.lightWhite,
                        bottom: 12,
                      ),
                      CustomText(
                        fontSize: 14.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w400,
                        text: AppStrings.createANewPasswordEnsureIt,
                        color: AppColors.normalWhite,
                        bottom: 215,
                      ),

                      ///====================================Password Field======================
                      CustomTextField(
                        textEditingController:
                        authenticationController.passwordController,
                        fillColor: AppColors.lightWhite,
                        hintText: AppStrings.password,
                        hintStyle: const TextStyle(color: AppColors.buttonColor),
                        isPassword: true,
                      ),
                      SizedBox(height: 24.h),

                      ///===============================Confirm Password========================
                      CustomTextField(
                        textEditingController:
                        authenticationController.confirmPasswordController,
                        fillColor: AppColors.lightWhite,
                        hintText: AppStrings.confirmPassword,
                        hintStyle: const TextStyle(color: AppColors.buttonColor),
                        isPassword: true,
                      ),
                      SizedBox(height: 24.h),

                      ///======================================Update Password Button==================
                      authenticationController.isResetLoading.value
                          ? const CustomLoader()
                          : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authenticationController.resetPassword();
                          }
                        },
                        title: AppStrings.updatePassword,
                        fillColor: AppColors.buttonColor,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
