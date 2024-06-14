import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController{
  var isExpandedList = List<bool>.filled(5, false).obs;

  void toggleExpand(int index) {
    isExpandedList[index] = !isExpandedList[index];
  }


  ///============================favorite list=======================
  final List<String> movie = [
    AppConstants.lover,
    AppConstants.loveAgain,
    AppConstants.movieImage,
    AppConstants.chinaMovie,
  ];
}