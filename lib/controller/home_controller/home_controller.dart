import 'package:final_movie/model/banner_model/banner_model.dart';
import 'package:final_movie/model/movie_model/movies_model.dart';
import 'package:final_movie/model/studio/studio_model.dart';
import 'package:final_movie/model/tv_series_model/tv_series_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'dart:async';

class HomeController extends GetxController {



  RxInt bannerIndex = 0.obs;
  Rx<PageController> pageController = PageController().obs;






  ///====================================top rating movies ======================
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  ///===============================Banner======================
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;




  RxList<BannerData> bannerList = <BannerData>[].obs;
  var title = "Loading...".obs;
  Timer? _timer;
  int currentIndex = 0;

  getBanner() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.bannerMovie);

    if (response.statusCode == 200) {
      bannerList.value = List<BannerData>.from(
          response.body["data"].map((x) => BannerData.fromJson(x)));
      print('BannerList=========================="${bannerList.length}"');

      // Timer সেটআপ করা, যাতে একে একে সব title দেখানো হয়
      if (bannerList.isNotEmpty) {
        // প্রথম title দেখাবে
        currentIndex = 0;
        title.value = bannerList[currentIndex].title ?? "No Title";
        updateWidgetTitle();

        // Timer শুরু করা, যাতে প্রতিটি title নির্দিষ্ট সময় পরপর দেখানো হয়
        _timer?.cancel(); // যদি পূর্বের কোনো timer চলে তখন সেটি বন্ধ করে নতুন timer সেট করুন
        _timer = Timer.periodic(Duration(minutes: 1), (timer) {
          currentIndex = (currentIndex + 1) % bannerList.length;
          title.value = bannerList[currentIndex].title ?? "No Title";
          updateWidgetTitle();
        });
      }

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

// Title update করার ফাংশন
  void updateWidgetTitle() async {
    await HomeWidget.saveWidgetData<String>('api_title', title.value);
    await HomeWidget.updateWidget(
      name: 'HomeScreenWidgetProvider',
      iOSName: 'HomeScreenWidgetProvider',
    );
  }






  RxList<MoviesData> moviesList = <MoviesData>[].obs;
  RxList<MoviesData> searchMovieList = <MoviesData>[].obs;

  Future<void> getMovies({required MovieListType listType}) async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(ApiUrl.getMovies);

    if (response.statusCode == 200) {
      List<MoviesData> fetchedMovies = List<MoviesData>.from(
          response.body["data"].map((x) => MoviesData.fromJson(x)));
      if (listType == MovieListType.movies) {
        moviesList.value = fetchedMovies;
        print('moviesList count:========== ${moviesList.length}');
      } else if (listType == MovieListType.searchMovies) {
        searchMovieList.value = fetchedMovies;
        print('searchMovieList count: ============${searchMovieList.length}');
      }

      setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///====================================Get Tv================
  RxList<TvSeriesData> tvList = <TvSeriesData>[].obs;

  getTv() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getTv);

    if (response.statusCode == 200) {
      tvList.value = List<TvSeriesData>.from(
          response.body["data"].map((x) => TvSeriesData.fromJson(x)));
      print('TvSeriesList=========================="${tvList.length}"');

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







  ///=======================================Studio======================
  RxList<StudioData> studioDataList = <StudioData>[].obs;

  getStudio() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getAllStudio);

    if (response.statusCode == 200) {
      studioDataList.value = List<StudioData>.from(
          response.body["data"].map((x) => StudioData.fromJson(x)));
      print('StudioList=========================="${studioDataList.length}"');

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



  ///<<<<<<<<<<======================================Search Method====================>>>>>>>
  TextEditingController searchController = TextEditingController();

  searchMovie({required String search}) async {
    setRxRequestStatus(Status.loading);
    searchMovieList.refresh();
    var response = await ApiClient.getData("${ApiUrl.search}=$search");
    searchMovieList.refresh();
    if (response.statusCode == 200) {
      searchMovieList = RxList<MoviesData>.from(
          response.body["data"].map((x) => MoviesData.fromJson(x)));
      setRxRequestStatus(Status.completed);
      searchMovieList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  customMethod() {
    getBanner();
    getMovies(listType: MovieListType.movies);
    getTv();
    getStudio();
  }

  @override
  void onInit() {
    customMethod();
    super.onInit();
  }
}


enum MovieListType { movies, searchMovies }
