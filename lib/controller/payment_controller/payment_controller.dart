import 'dart:convert';
import 'package:final_movie/helpar/shared_prefe/shared_prefe.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {






  ///========================= Create Payment Intent =========================
  Map<String, dynamic> value = {};

  Future<Map<String, dynamic>> createPaymentIntent({
    required int amount,
  }) async {
    var bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "amount": amount,
    };
    try {
      var response = await ApiClient.postData(
          ApiUrl.createPaymentIntent, jsonEncode(body),
          headers: mainHeaders);
      debugPrint("==============Payment Intent body ===========${response.body}");

      if (response.statusCode == 200) {
        value = response.body["data"];
        return value;
      } else {
        ApiChecker.checkApi(response);
        return {};
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
      print(error);
      return {};
    }
  }

  ///========================= Make Payment =========================
  Future<void> makePayment({
    required int amount,
  }) async {
    try {
      Map<String, dynamic> paymentIntentData =
      await createPaymentIntent(amount: amount);

      if (paymentIntentData.isNotEmpty) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              merchantDisplayName: 'Masum',
              paymentIntentClientSecret: paymentIntentData['clientSecret'],
              allowsDelayedPaymentMethods: true,
              style: ThemeMode.light,
            ));
        await Stripe.instance.presentPaymentSheet();

        // Send payment status to the server
        makeOrder(
          transactionId: paymentIntentData['transactionId'] ?? "",
          clientSecret: paymentIntentData['clientSecret'],
        );

        toastMessage(message: "Payment Successful");
      }
    } catch (e) {
      debugPrint("Error ================>>>>>>>>>>>>>${e.toString()}");
      toastMessage(message: "Error $e");
    }
  }

  ///============================ Send Response to Server ==============================
  makeOrder({
    required String transactionId,
    required String clientSecret,
  }) async {
    var bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    Map<String, dynamic> body = {
      "transactionId": transactionId,
      "clientSecret": clientSecret,
    };
    var response = await ApiClient.postData(
        ApiUrl.savePayment, jsonEncode(body),
        headers: mainHeaders);
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
