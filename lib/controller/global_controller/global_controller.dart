import 'package:final_movie/helpar/shared_prefe/shared_prefe.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxBool isPayment = false.obs;

  /// Load `isPayment` status from SharedPreferences on app startup
  Future<void> loadPaymentStatus() async {
    isPayment.value = await SharePrefsHelper.getBool(AppConstants.isPayment) ?? false;
    debugPrint("Subscription Info: $isPayment");
  }

  /// Update `isPayment` status in both SharedPreferences and `isPayment` observable
  Future<void> updatePaymentStatus(bool status) async {
    isPayment.value = status;
    await SharePrefsHelper.setBool(AppConstants.isPayment, status);
    debugPrint("Updated Subscription Info: $isPayment");
  }

  @override
  void onInit() {
    super.onInit();
    loadPaymentStatus(); // Load payment status when controller initializes
  }
}
