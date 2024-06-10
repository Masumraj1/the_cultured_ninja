import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/authentication/authentication_controller/authentication_controller.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});
 final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
     () {
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
                top: 134,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      ///===============================Login Your Account=====================
                      CustomText(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        text: AppStrings.signUpYourAccount,
                        color: AppColors.lightWhite,
                        bottom: 33,
                      ),

                      ///====================================User Name======================
                      const CustomTextField(
                        fillColor: AppColors.lightWhite,
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.buttonColor,
                        ),
                        isPrefixIcon: true,
                        hintText: AppStrings.userName,
                        hintStyle: TextStyle(color: AppColors.buttonColor),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      ///====================================Email Field======================
                      const CustomTextField(
                        fillColor: AppColors.lightWhite,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.buttonColor,
                        ),
                        isPrefixIcon: true,
                        hintText: AppStrings.email,
                        hintStyle: TextStyle(color: AppColors.buttonColor),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      ///====================================Password ==============================
                      const CustomTextField(
                        fillColor: AppColors.lightWhite,
                        isPassword: true,
                        hintText: AppStrings.password,
                        hintStyle: TextStyle(color: AppColors.buttonColor),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      const CustomTextField(
                        fillColor: AppColors.lightWhite,
                        isPassword: true,
                        hintText: AppStrings.confirmPassword,
                        hintStyle: TextStyle(color: AppColors.buttonColor),
                      ),

                      ///===================================Remember me=========================
                      Row(
                        children: [
                          Checkbox(
                            value: authenticationController.isRemember.value,
                            checkColor: AppColors.lightWhite,
                            activeColor: AppColors.buttonColor,
                            onChanged: (value) {
                              authenticationController.toggleRemember();
                            },
                          ),
                          const CustomText(
                            text: AppStrings.rememberMe,
                            color: AppColors.lightWhite,
                          ),
                        ],
                      ),

                      ///======================================Sign In Button==================
                      CustomButton(
                        onTap: () {},
                        title: AppStrings.signIn,
                        fillColor: AppColors.buttonColor,
                      ),

                      ///=======================================Forget Password===================
                      CustomText(
                        top: 10,
                        text: AppStrings.forgotPassword,
                        color: AppColors.lightWhite,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        bottom: 150,
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
