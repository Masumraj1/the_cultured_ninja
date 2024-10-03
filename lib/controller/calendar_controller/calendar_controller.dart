import 'dart:convert';

import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:get/get.dart';

import '../../services/api_client.dart';

class CalendarController extends GetxController {
  var dates = <DateTime?>[DateTime.now()].obs;

  void updateDates(List<DateTime?> newDates) {
    dates.value = newDates;
  }



  ///===============================Added Calender=====================
  RxBool isAdded = false.obs;

  addedCalender({required String id}) async {
    isAdded.value = true;
    refresh();
    Map<String, String> body = {
      "movie": id,
      "date":"24-11-2024"
    };
    var response = await ApiClient.postData(
      ApiUrl.getCalenderMovie,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
          Get.back();
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isAdded.value = false;
    refresh();
  }

}
