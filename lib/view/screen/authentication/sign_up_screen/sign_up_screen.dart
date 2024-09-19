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

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Form(
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
                      ///===============================signUpYourAccount=====================
                      CustomText(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        text: AppStrings.signUpYourAccount,
                        color: AppColors.lightWhite,
                        bottom: 33,
                      ),

                      ///====================================User Name======================
                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value.length < 4) {
                            return AppStrings.enterAValidName;
                          }
                          return null;
                        },
                        textEditingController:
                            authenticationController.nameController,
                        fillColor: AppColors.lightWhite,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: AppColors.buttonColor,
                        ),
                        isPrefixIcon: true,
                        hintText: AppStrings.userName,
                        hintStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                      SizedBox(
                        height: 24.h,
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

                      ///====================================Password ==============================
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.passwordMustHaveEightWith;
                          } else if (value.length < 8 ||
                              !AppStrings.passRegexp.hasMatch(value)) {
                            return AppStrings.passwordLengthAndContain;
                          } else {
                            return null;
                          }
                        },
                        textEditingController:
                            authenticationController.passwordController,
                        fillColor: AppColors.lightWhite,
                        isPassword: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.buttonColor,
                        ),
                        hintText: AppStrings.password,
                        hintStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      ///====================================Confirm password ==============
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value !=
                              authenticationController
                                  .passwordController.text) {
                            return "Password should match";
                          }
                          return null;
                        },
                        textEditingController:
                            authenticationController.confirmPasswordController,
                        fillColor: AppColors.lightWhite,
                        isPassword: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.buttonColor,
                        ),
                        hintText: AppStrings.confirmPassword,
                        hintStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),

                      SizedBox(
                        height: 30.h,
                      ),

                      ///======================================Sign Up Button==================

                      authenticationController.isSignUpLoading.value
                          ? const CustomLoader()
                          :
                      CustomButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  authenticationController.signUp();
                                }
                              },
                              title: AppStrings.signUp,
                              fillColor: AppColors.buttonColor,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
