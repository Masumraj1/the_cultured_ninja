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

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final formKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Form(
          key: formKey,
          child: Stack(
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
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ))),
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
                        text: AppStrings.forgotPassword,
                        color: AppColors.lightWhite,
                        bottom: 12,
                      ),
                      CustomText(
                        fontSize: 14.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w400,
                        text: AppStrings.dontWorryInAccurse,
                        color: AppColors.normalWhite,
                        bottom: 215,
                      ),

                      ///====================================Email Field======================
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterValidEmail;
                          } else if (!AppStrings.emailRegexp.hasMatch(
                              authenticationController.emailController.text)) {
                            return AppStrings.enterValidEmail;
                          } else {
                            return null;
                          }
                        },
                        textEditingController:
                            authenticationController.emailController,
                        fillColor: AppColors.lightWhite,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.buttonColor,
                        ),
                        isPrefixIcon: true,
                        hintText: AppStrings.email,
                        hintStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      ///======================================send A code Button==================
                      authenticationController.isForgetLoading.value
                          ? const CustomLoader()
                          : CustomButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  authenticationController.forgetPassword();
                                }
                              },
                              title: AppStrings.sendACode,
                              fillColor: AppColors.buttonColor,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
