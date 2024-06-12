import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  ///================================BannerImage=========================
  final List<String> bannerImg = [
    AppImages.onBoardingThree,
    AppImages.onBoardingTwo,
    AppImages.onBoardingOne,
  ];

  RxInt bannerIndex = 0.obs;
  Rx<PageController> pageController = PageController().obs;

}