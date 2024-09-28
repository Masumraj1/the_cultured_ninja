import 'dart:convert';

import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GeneralController extends GetxController{



  ///========================================================Change Password=========================
 TextEditingController oldPasswordController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 TextEditingController confirmPasswordController = TextEditingController();
 TextEditingController emailController = TextEditingController();
  RxBool isChangeLoading = false.obs;

  changePassword() async {
    isChangeLoading.value = true;
    refresh();
    Map<String, String> body = {
      "old_Password": oldPasswordController.text,
      "password": passwordController.text,
      "confirm_password":confirmPasswordController.text
    };

    var response = await ApiClient.patchData(
      ApiUrl.changePassword,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      oldPasswordController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      Get.back();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isChangeLoading.value = false;
  }




}