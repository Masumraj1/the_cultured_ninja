import 'package:get/get.dart';

class StudiosController extends GetxController{


  RxBool isTap = false.obs;
  void toggleTap() {
    isTap.value = !isTap.value;
  }
}