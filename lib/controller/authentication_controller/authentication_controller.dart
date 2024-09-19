import 'dart:convert';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/shared_prefe/shared_prefe.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  ///=======================Remember me ========================
  RxBool isRemember = false.obs;

  toggleRemember() {
    isRemember.value = !isRemember.value;
    debugPrint("Remember me==============>>>>>>>>>$isRemember");
    refresh();
    SharePrefsHelper.setBool(AppConstants.isRememberMe, isRemember.value);
  }

  ///======================================controller====================
  TextEditingController emailController =
      TextEditingController(text: kDebugMode ? "masumrna927@gmail.com" : "");
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "Masum017@@@@" : "");
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  ///==========================Authentication All api here ===========================

  ///=================================SignUp ========================
  RxBool isSignUpLoading = false.obs;

  signUpAuth() async {
    isSignUpLoading.value = true;
    refresh();
    Map<String, String> body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "confirm_password": confirmPasswordController.text,
    };

    var response =
        await ApiClient.postData(ApiUrl.signupAuth, jsonEncode(body));
    if (response.statusCode == 200) {
      isSignUpLoading.value = false;
      refresh();
      Get.toNamed(
        AppRoute.forgetOtp,
      );
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isSignUpLoading.value = false;
    refresh();
  }

  ///=====================Sign up Otp==================
  var activationCode = "";
  RxBool isOtpLoading = false.obs;

  signUpVerifyOTP() async {
    isOtpLoading.value = true;
    refresh();
    Map<dynamic, String> body = {
      "email": emailController.text,
      "code": activationCode
    };

    var response =
        await ApiClient.postData(ApiUrl.verifyCOde, jsonEncode(body));
    isOtpLoading.value = false;
    refresh();
    if (response.statusCode == 200) {
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      nameController.clear();

      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body["accessToken"]);
      print(
          '======================This is  User Name ${response.body["data"]['name']}');
      print(
          '======================User Token Saved::: ${response.body['accessToken']}');

      Get.offAllNamed(AppRoute.homeScreen);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isOtpLoading.value = false;
    refresh();
  }

  ///============================ Forget Password ==========================

  RxBool isOtpLoadings = false.obs;

  forgetPassword() async {
    isOtpLoadings.value = true;
    refresh();
    Map<dynamic, String> body = {"email": emailController.text};
    var response =
        await ApiClient.postData(ApiUrl.forgotPasswordAuth, jsonEncode(body));
    isOtpLoadings.value = false;
    refresh();
    if (response.statusCode == 200) {
      emailController.clear();
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isOtpLoadings.value = false;
    refresh();
  }

  ///============================= reset Password =============================
  RxBool isResetLoading = false.obs;

  resetPassword() async {
    isResetLoading.value = true;
    refresh();
    Map<String, String> body = {
      "password": passwordController.text,
      "confirm_password": confirmPasswordController.text
    };

    var response =
        await ApiClient.postData(ApiUrl.resetPasswordAuth, jsonEncode(body));
    if (response.statusCode == 200) {
      passwordController.clear();
      confirmPasswordController.clear();
      Get.toNamed(AppRoute.signInScreen);
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isResetLoading.value = false;
  }

  ///============================== LogIn ================================
  RxBool isSignInLoading = false.obs;

  signInUser() async {
    isSignInLoading.value = true;
    refresh();
    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text
    };
    var response = await ApiClient.postData(
      ApiUrl.signInAuth,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body["token"]);
      print(
          '======================This is User Token ${response.body['token']}');
      Get.toNamed(AppRoute.homeScreen);
      toastMessage(
        message: response.body["message"],
      );
    } else if (response.statusCode == 401) {
      ApiChecker.checkApi(response);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isSignInLoading.value = false;
    refresh();
  }
}
