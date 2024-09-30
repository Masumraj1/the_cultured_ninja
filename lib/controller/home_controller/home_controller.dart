import 'package:final_movie/model/banner_model.dart';
import 'package:final_movie/model/movies_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
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


    ///===============================Banner======================
  final rxRequestStatus = Status.loading.obs;
  RxInt currentBannerIndex = 0.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

   RxList<BannerData> bannerList = <BannerData>[].obs;
  getBanner() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.bannerMovie);

    if (response.statusCode == 200) {
      bannerList.value = List<BannerData>.from(
          response.body["data"].map((x) => BannerData.fromJson(x)));
      print('BannerList=========================="${bannerList.length}"');

      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }


  ///====================================Get Movies================
  RxList<MoviesData> moviesList = <MoviesData>[].obs;
  getMovies() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getMovies);

    if (response.statusCode == 200) {
      moviesList.value = List<MoviesData>.from(
          response.body["data"].map((x) => MoviesData.fromJson(x)));
      print('moviesList=========================="${moviesList.length}"');


      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }


  customMethod (){
    getBanner();
    getMovies();

  }


  @override
  void onInit() {
    customMethod();
    super.onInit();
  }
}
