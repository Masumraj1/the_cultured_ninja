import 'package:final_movie/controller/authentication_controller/authentication_controller.dart';
import 'package:final_movie/controller/payment_controller/payment_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  final PaymentController paymentController = Get.find<PaymentController>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: Form(
            key: formKey,
            child: Stack(
              children: [
                ///=============================BackGround Image========================
                Container(
                  height: double.infinity,
                  width: double.infinity,
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
                  top: 44.h, // Adjusted for responsiveness
                  left: 20.w,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),

                ///========================This is loader=====================
                Positioned(
                  top: 134.h, // Adjusted for responsiveness
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///===============================Login Your Account=====================
                          CustomText(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            text: AppStrings.loginYourAccount,
                            color: AppColors.lightWhite,
                            bottom: 141.h,
                          ),

                          ///====================================Email Field======================
                          CustomTextField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.enterValidEmail;
                              } else if (!AppStrings.emailRegexp.hasMatch(
                                  authenticationController
                                      .emailController.text)) {
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
                            isPrefixIcon: true,
                            hintText: AppStrings.password,
                            hintStyle:
                                const TextStyle(color: AppColors.buttonColor),
                          ),

                          // ///===================================Remember me=========================
                          // Row(
                          //   children: [
                          //     Checkbox(
                          //       value: authenticationController.isRemember.value,
                          //       checkColor: AppColors.lightWhite,
                          //       activeColor: AppColors.buttonColor,
                          //       onChanged: (value) {
                          //         authenticationController.toggleRemember();
                          //       },
                          //     ),
                          //     const CustomText(
                          //       text: AppStrings.rememberMe,
                          //       color: AppColors.lightWhite,
                          //     ),
                          //   ],
                          // ),
                         SizedBox(height: 20.h
                           ,),
                          ///======================================Sign In Button==================

                          authenticationController.isSignInLoading.value
                              ? const CustomLoader()
                              : CustomButton(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      authenticationController.signInUser();

                                    }
                                  },
                                  title: AppStrings.signIn,
                                  fillColor: AppColors.buttonColor,
                                ),

                          ///=======================================Forget Password===================
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.forgetPassword);
                            },
                            child: CustomText(
                              top: 10.h,
                              text: AppStrings.forgotPassword,
                              color: AppColors.lightWhite,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              bottom: 150.h,
                            ),
                          ),

                          ///=======================================Sign Up Button===================
                          RichText(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: AppStrings.dontHaveAnAccount,
                                  style: TextStyle(
                                    color: AppColors.lightWhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.signUp,
                                  style: TextStyle(
                                    color: AppColors.buttonColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoute.signUpScreen);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
