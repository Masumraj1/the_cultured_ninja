import 'package:get/get.dart';

class CalendarController extends GetxController {
  var dates = <DateTime?>[DateTime.now()].obs;

  void updateDates(List<DateTime?> newDates) {
    dates.value = newDates;
  }
}
