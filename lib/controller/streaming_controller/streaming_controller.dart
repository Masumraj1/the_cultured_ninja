import 'dart:convert';

import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/model/filter_model/filter_model.dart';
import 'package:final_movie/model/streaming_model/all_streaming_model.dart';
import 'package:final_movie/model/streaming_model/movie_genre_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StreamingController extends GetxController{

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///====================================Get All Studio===========
  RxList<StreamingData> streamList = <StreamingData>[].obs;
  getAllStudio() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getAllStudio);

    if (response.statusCode == 200) {
      streamList.value = List<StreamingData>.from(
          response.body["data"].map((x) => StreamingData.fromJson(x)));

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

  ///====================================Get All Genre===========
  RxList<MovieGenreData> genreData = <MovieGenreData>[].obs;
  getAllGenre() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getMovieGenre);

    if (response.statusCode == 200) {
      genreData.value = List<MovieGenreData>.from(
          response.body["data"].map((x) => MovieGenreData.fromJson(x)));

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


  ///===============================Genre Updated================
  RxBool isUpdate = false.obs;

  Future<void> genreUpdate({Map<String, String>? header,
    required TextEditingController genreController}) async {
    if (genreController.text.isEmpty) {
      toastMessage(message: "Genre cannot be empty");
      return; // Exit if genre is empty
    }

    isUpdate.value = true;
    update(); // Notify listeners that state has changed

    try {
      var body = {
        "genres": jsonEncode([genreController.text]),
      };

      var response = await ApiClient.patchMultipartData(
        ApiUrl.editProfile,
        body,
        haveImage: false

      );

      if (response.statusCode == 200) {
        // toastMessage(message: response.body["message"]);
        Get.toNamed(AppRoute.homeScreen); // Navigate to home screen
      } else {
        ApiChecker.checkApi(response); // Handle other response codes
      }
    } catch (e) {
      debugPrint("Error occurred: $e"); // Print the error for debugging
    } finally {
      isUpdate.value = false; // Reset loading state
      update(); // Notify listeners that state has changed
    }
  }


  ///===================================Genre Filtering===================
  RxString selectedGenre = ''.obs; // Use a reactive String to track selected genre

  void selectGenre(String genreId, String genreName) {
    if (selectedGenre.value == genreName) {
      selectedGenre.value = ''; // Deselect if the same genre is tapped again
    } else {
      selectedGenre.value = genreName; // Select the tapped genre
    }
  }



  RxList<FilterData> filterList = <FilterData>[].obs;

  getFilter({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.filterMovie(id: id));

    if (response.statusCode == 200) {
      filterList.value = List<FilterData>.from(
          response.body["data"].map((x) => FilterData.fromJson(x)));
      print('FilterList=========================="${filterList.length}"');

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



  @override
  void onInit() {
    getAllStudio();
    getAllGenre();
    super.onInit();
  }
}