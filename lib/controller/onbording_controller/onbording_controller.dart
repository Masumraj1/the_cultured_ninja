import 'package:get/get.dart';
import 'package:final_movie/helpar/shared_prefe/shared_prefe.dart';
import 'package:final_movie/utils/app_const/app_const.dart';

class OnBoardingController extends GetxController {
  var currentIndex = 0.obs;
  List<String> titleFirstPart = [
    "The best movies Streaming app of the century to make your days great!",
    "The best movies Streaming app of the century to make your days great!",
    "The best movies Streaming app of the century to make your days great!"
  ];

  @override
  void onInit() {
    SharePrefsHelper.setBool(AppConstants.onBoard, true);
    super.onInit();
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}
