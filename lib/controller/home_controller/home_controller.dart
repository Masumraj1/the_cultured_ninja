import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ///================================BannerImage=========================
  final List<String> bannerImg = [
    AppImages.onBoardingThree,
    AppImages.onBoardingTwo,
    AppImages.onBoardingOne,
  ];

  final List<String> tvSeriesList = [
    AppConstants.loveAgain,
    AppConstants.movieImage,
    AppConstants.tvSeries,
    AppConstants.lover,
  ];
  final List<String> movie = [
    AppConstants.lover,
    AppConstants.loveAgain,
    AppConstants.movieImage,
    AppConstants.chinaMovie,
  ];
  final List<String> studiosList = [
    AppConstants.disneyPlus,
    AppConstants.netFlix,
    AppConstants.disneyPlus,
    AppConstants.movieStudio,
    AppConstants.netFlix,


  ];
  RxInt bannerIndex = 0.obs;
  Rx<PageController> pageController = PageController().obs;

  ///=======================================Movie details screen============================
  var isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
  RxBool isTap = false.obs;
  void toggleTap() {
    isTap.value = !isTap.value;
  }
  ///====================================top rating movies ======================
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
