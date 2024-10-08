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

  var selectedDate = DateTime.now().obs; // Add this observable for the selected date

  void addCalender({required String id}) {
    isAdded.value = true; // Just an example, update this according to your logic
  }

  ///===============================Added Calender=====================

  RxBool isAdded = false.obs;

  addedCalender({required String id,required String date}) async {
    isAdded.value = true;
    refresh();
    Map<String, String> body = {
      "movie": id,
      "date":date
    };
    var response = await ApiClient.postData(
      ApiUrl.addedCalender,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      toastMessage(
        message: response.body["message"],
      );
          Get.back();

    } else {
      ApiChecker.checkApi(response);
    }
    isAdded.value = false;
    refresh();
  }

}
