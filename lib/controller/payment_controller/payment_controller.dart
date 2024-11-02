import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController{

  showPopUpLoader() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (_) {
          return const SizedBox(
            height: 70,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: CustomLoader(),
            ),
          );
        });
  }
  Future<Map<String, dynamic>?> createPaymentIntent({
    required String amount,
  }) async {
   showPopUpLoader();

    Map<String, dynamic> body = {"amount": amount};
    var response = await ApiClient.postData(
     ApiUrl.createPaymentIntent, body);

    if (response.statusCode == 200) {
      return response.body["data"];
    } else {
      ApiChecker.checkApi(response);
      navigator!.pop();
      return null;
    }
  }
}