import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class StudiosController extends GetxController{


  RxBool isTap = false.obs;
  void toggleTap() {
    isTap.value = !isTap.value;
  }


  final List<String> tvSeriesList = [
    AppConstants.disneyPlus,
    AppConstants.netFlix,
    AppConstants.disneyPlus,
    AppConstants.movieStudio,
    AppConstants.netFlix,


  ];
}