import 'package:final_movie/helpar/shared_prefe/shared_prefe.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController{
  RxBool isRemember = false.obs;
  toggleRemember() {
    isRemember.value = !isRemember.value;
    debugPrint("Remember me==============>>>>>>>>>$isRemember");
    refresh();

    SharePrefsHelper.setBool(AppConstants.isRememberMe, isRemember.value);
  }
}