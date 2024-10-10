import 'dart:convert';
import 'dart:ffi';

import 'package:final_movie/controller/favorite_controller/favorite_controller.dart';
import 'package:final_movie/controller/following_controller/following_controller.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/model/actor_details_model/actor_details_model.dart';
import 'package:final_movie/model/movie_details_model/movie_details.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class MovieDetailsController extends GetxController {
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  var isFavorite = false.obs;
  var isWatched = false.obs;

  ///====================================Movie Details================

  // movieDetails({required String id}) async {
  //   setRxRequestStatus(Status.loading);
  //   refresh();
  //   var response = await ApiClient.getData(ApiUrl.movieDetails(id: id));
  //
  //   if (response.statusCode == 200) {
  //     moviesDetailsModel.value = DetailsData.fromJson(response.body["data"]);
  //
  //     print('data fetch==================="${response.body["data"]}"');
  //     print(
  //         'backdrop_path==================="${response.body["data"]['details']["backdrop_path"]}"');
  //     print(
  //         'actorList==================="${moviesDetailsModel.value.actors?.length}');
  //     print(
  //         'SimilarMovies==================="${moviesDetailsModel.value.similarMovies?.length}');
  //
  //     // print('Length================="${actorList.length}"');
  //
  //     setRxRequestStatus(Status.completed);
  //     refresh();
  //   } else {
  //     if (response.statusText == ApiClient.noInternetMessage) {
  //       setRxRequestStatus(Status.internetError);
  //     } else {
  //       setRxRequestStatus(Status.error);
  //     }
  //     ApiChecker.checkApi(response);
  //   }
  // }
  Rx<DetailsData> moviesDetailsModel = DetailsData().obs;

  Future<void> movieDetails({required String id}) async {
    setRxRequestStatus(Status.loading);

    try {
      var response = await ApiClient.getData(ApiUrl.movieDetails(id: id));

      if (response.statusCode == 200) {
        moviesDetailsModel.value = DetailsData.fromJson(response.body["data"]);

        // Set favorite and watched states based on API response
        isFavorite.value = moviesDetailsModel.value.favorite ?? false;
        isWatched.value = moviesDetailsModel.value.watched ?? false;

        setRxRequestStatus(Status.completed);
      } else {
        if (response.statusText == ApiClient.noInternetMessage) {
          setRxRequestStatus(Status.internetError);
        } else {
          setRxRequestStatus(Status.error);
        }
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
    }
  }

  ///====================================Actor Details================
  Rx<ActorDetailsData> actorDetails = ActorDetailsData().obs;

  actorDetail({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.actorDetails(id: id));

    if (response.statusCode == 200) {
      actorDetails.value = ActorDetailsData.fromJson(response.body["data"]);
      isFollowed.value = actorDetails.value.isFollowed ?? false;

      print('actor data ========================="${response.body['data']}"');
      print(
          'Upcoming list ========================="${actorDetails.value.upcomingMovies?.length}"');
      // print('Upcoming movie Id ========================="${response.body['data']['upcoming_movies']['id']}"');
      print(
          'popular Movies ========================="${actorDetails.value.popularMovies?.length}"');

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

  ///=============================actor Follow======================



  var isFollowed = false.obs;

  Future<bool> toggleActorFlow(String actorId) async {
    isFollowed.value = !isFollowed.value;

    // Optionally: Call an API to persist this watched state
    return await addFollow(id: actorId);
  }

  // final FollowingController followingController = Get.find<FollowingController>();
  RxBool isTap = false.obs;

  Future<bool> addFollow({required String id}) async {
    isTap.value = true;
    refresh();
    Map<String, String> body = {"actorId": id, "type": "actor"};
    var response = await ApiClient.postData(ApiUrl.addFlow, jsonEncode(body));
    if (response.statusCode == 201) {
      // followingController.getFlowing();
      toastMessage(
        message: response.body["message"],
      );
      return false;
    } else if (response.statusCode == 200) {
      toastMessage(
        message: response.body["message"],
      );
      return true;
    } else {
      ApiChecker.checkApi(response);
      return false;
    }
  }





  ///===========================Add Favorite================
  FavoriteController favoriteController = Get.find<FavoriteController>();

  void toggleFavorite(String movieId) {
    isFavorite.value = !isFavorite.value;

    // Optionally: Call an API to persist this favorite state
    addFavorite(id: movieId);
  }

  RxBool isFavorites = false.obs;

  addFavorite({required String id}) async {
    isFavorites.value = true;
    refresh();
    Map<String, String> body = {};
    var response =
        await ApiClient.postData(ApiUrl.addFavorite(id: id), jsonEncode(body));
    if (response.statusCode == 200) {
      favoriteController.getFavorite();
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isFavorites.value = false;
    refresh();
  }

  ///===========================Add History================
  void toggleWatched(String movieId) {
    isWatched.value = !isWatched.value;

    // Optionally: Call an API to persist this watched state
    addHistory(id: movieId);
  }

  RxBool isHistory = false.obs;

  addHistory({required String id}) async {
    isHistory.value = true;
    refresh();
    Map<String, String> body = {};
    var response =
        await ApiClient.postData(ApiUrl.addHistory(id: id), jsonEncode(body));
    if (response.statusCode == 200) {
      // Get.back();
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isHistory.value = false;
    refresh();
  }
}
