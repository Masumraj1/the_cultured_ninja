import 'dart:async';
import 'package:final_movie/controller/authentication_controller/authentication_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetOtp extends StatefulWidget {
  const ForgetOtp({super.key});

  @override
  State<ForgetOtp> createState() => _ForgetOtpState();
}

class _ForgetOtpState extends State<ForgetOtp> {
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final String isSignUp = Get.parameters[AppStrings.signUp] ?? "true";
  final formKey = GlobalKey<FormState>();
  int _secondsRemaining = 200;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

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
                image: AssetImage(AppImages.background),
              ),
            ),
          ),

          ///=============================Back Button==============================
          Positioned(
            top: 44,
            left: 20,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          ///=============================OTP Form==============================
          Positioned(
            top: 134,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Obx(() {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ///=============================Header Text=============================
                      SizedBox(height: 50.h,),

                      CustomText(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        text: AppStrings.checkYourEmail,
                        color: AppColors.lightWhite,
                        bottom: 12,
                      ),
                      // CustomText(
                      //   fontSize: 14.sp,
                      //   maxLines: 3,
                      //   fontWeight: FontWeight.w400,
                      //   text: AppStrings.weSentAResetLink,
                      //   color: AppColors.normalWhite,
                      //   bottom: 73,
                      // ),
                      SizedBox(height: 50.h,),

                      ///=============================Pin Code Text Field=============================
                      PinCodeTextField(
                        textStyle: const TextStyle(color: AppColors.lightWhite),
                        keyboardType: TextInputType.phone,
                        autoDisposeControllers: false,
                        cursorColor: AppColors.buttonColor,
                        appContext: context,
                        controller: authenticationController.pinCodeController,
                        onCompleted: (value) {
                          if (isSignUp == "true") {
                            authenticationController.activationCode = value;
                          } else {
                            authenticationController.otp = value;
                          }
                        },
                        validator: (value) {
                          if (value!.length == 4) {
                            return null; // Input is valid
                          } else {
                            return "Please enter a 4-digit OTP code"; // Input is invalid
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _secondsRemaining == 0
                              ? () {
                            _secondsRemaining = 200; // Reset timer
                            startTimer(); // Start the timer again

                            // Call the resend function
                            authenticationController.resentUser().then((value) {
                              if (!value) {
                                setState(() {
                                  _timer.cancel(); // Cancel timer if resend failed
                                  _secondsRemaining = 0;
                                });
                              }
                            });
                          }
                              : null,
                          child: CustomText(
                            text: _secondsRemaining == 0
                                ? "Resend OTP"
                                : "Resend OTP in $_secondsRemaining seconds",
                            color: AppColors.lightWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 100.h),

                      ///=============================Verify Code Button=============================
                      authenticationController.isOtpLoading.value || authenticationController.isForget.value
                          ? const CustomLoader()
                          : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (isSignUp == "true" && isSignUp.isNotEmpty) {
                              authenticationController.signUpVerifyOTP();
                            } else {
                              authenticationController.forgetOtp();
                            }
                          }
                        },
                        title: AppStrings.verifyCode,
                        fillColor: AppColors.buttonColor,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
