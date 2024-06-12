import 'package:get/get.dart';

class FavoriteController extends GetxController{
  var isExpandedList = List<bool>.filled(5, false).obs;

  void toggleExpand(int index) {
    isExpandedList[index] = !isExpandedList[index];
  }
}