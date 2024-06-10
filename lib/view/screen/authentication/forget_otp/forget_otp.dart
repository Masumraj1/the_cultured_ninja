import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetOtp extends StatelessWidget {
  const ForgetOtp({super.key});

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
                    text: AppStrings.checkYourEmail,
                    color: AppColors.lightWhite,
                    bottom: 12,
                  ), CustomText(
                    fontSize: 14.sp,
                    maxLines: 3,
                    fontWeight: FontWeight.w400,
                    text: AppStrings.weSentAResetLink,
                    color: AppColors.normalWhite,
                    bottom: 73,
                  ),

             ///====================================Pin Code text field=============================
                  PinCodeTextField(
                    textStyle: const TextStyle(color: AppColors.lightWhite),
                    keyboardType: TextInputType.phone,
                    autoDisposeControllers: false,
                    cursorColor: AppColors.buttonColor,
                    appContext: (context),
                    // controller: authenticationController.pinController,
                    onCompleted: (value) {
                      // authenticationController.activationCode = value;
                    },
                    validator: (value) {
                      if (value!.length == 6) {
                        return null; // Input is valid
                      } else {
                        return "Please enter a 6-digit OTP code"; // Input is invalid
                      }
                    },
                    autoFocus: true,
                    pinTheme: PinTheme(
                      disabledColor: Colors.transparent,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 49.h,
                      fieldWidth: 47,
                      activeFillColor: AppColors.buttonColor,
                      selectedFillColor: AppColors.buttonColor,
                      inactiveFillColor: AppColors.borderColor,
                      borderWidth: 0.5,
                      activeBorderWidth: 0.8,
                      selectedColor: AppColors.buttonColor,
                      inactiveColor: AppColors.buttonColor,
                      activeColor: AppColors.buttonColor,
                    ),
                    length: 4,
                    enableActiveFill: true,
                  ),
                    
                    const Row(
                      children: [
                        SizedBox(),
                        Spacer(),
                        CustomText(text: AppStrings.resendOtp,color: AppColors.lightWhite,)
                      ],
                    ),
                    SizedBox(
                      height: 165.h,
                    ),
                  ///======================================send A code Button==================
                  CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoute.resetPassword);
                    },
                    title: AppStrings.verifyCode,
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
