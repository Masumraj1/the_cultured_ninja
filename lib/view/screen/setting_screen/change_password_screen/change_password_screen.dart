import 'package:final_movie/controller/genarel_controller/genarel_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final GeneralController generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///<<<<========================================Change Password AppBar======================================
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        title: CustomText(
          text: AppStrings.changePassword,
          color: AppColors.lightWhite,
          fontSize: 18.sp,
        ),
        backgroundColor: AppColors.blackDeep,
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: AppStrings.currentPassword,
                    color: AppColors.lightWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    bottom: 10,
                  ),

                  ///<<<<========================================Current Password Field======================================
                  CustomTextField(
                    hintText: AppStrings.password,
                    textEditingController:
                        generalController.oldPasswordController,
                    // textEditingController:profileController.currentPasswordController ,
                    keyboardType: TextInputType.name,
                    isPassword: true,
                    fillColor: AppColors.fromRgb,
                    fieldBorderColor: AppColors.fromRgb,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      } else if (value.length < 8 ||
                          !AppStrings.passRegexp.hasMatch(value)) {
                        return AppStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
                  ),

                  CustomText(
                    text: AppStrings.newPassword,
                    color: AppColors.lightWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    bottom: 10,
                    top: 27,
                  ),

                  ///<<<<========================================NewPassword Field======================================
                  CustomTextField(
                    isPassword: true,
                    fillColor: AppColors.fromRgb,
                    fieldBorderColor: AppColors.fromRgb,
                    textEditingController: generalController.passwordController,
                    keyboardType: TextInputType.name,
                    hintText: AppStrings.password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      } else if (value.length < 8 ||
                          !AppStrings.passRegexp.hasMatch(value)) {
                        return AppStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
                  ),

                  CustomText(
                    text: AppStrings.confirmPassword,
                    color: AppColors.lightWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    bottom: 10,
                    top: 27,
                  ),

                  ///<<<<========================================Confirm Password Field======================================
                  CustomTextField(
                    textEditingController:
                        generalController.confirmPasswordController,
                    keyboardType: TextInputType.name,
                    hintText: AppStrings.password,
                    fillColor: AppColors.fromRgb,
                    fieldBorderColor: AppColors.fromRgb,
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      } else if (generalController.passwordController.text !=
                          generalController.confirmPasswordController.text) {
                        return "Password should be match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 150.h,
                  ),

                  ///<<<<========================================Save And Update Button======================================

                  generalController.isChangeLoading.value
                      ? const CustomLoader()
                      : Center(
                          child: CustomButton(
                            fillColor: AppColors.buttonColor,
                            width: double.infinity,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                generalController.changePassword();
                              }
                            },
                            title: AppStrings.changePassword,
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
