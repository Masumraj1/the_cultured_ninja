import 'dart:convert';

import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/model/favorite_model/favorite_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var isExpandedList = List<bool>.filled(1, false).obs;

  void toggleExpand(int index) {
    isExpandedList[index] = !isExpandedList[index];
  }

  ///====================================GetFavorite Method================
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  RxList<FavoriteData> favoriteList = <FavoriteData>[].obs;

  getFavorite() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getFavorite);

    if (response.statusCode == 200) {
      favoriteList.value = List<FavoriteData>.from(
          response.body["data"].map((x) => FavoriteData.fromJson(x)));
      print('favoriteList=========================="${favoriteList.length}"');

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


  ///===========================Add Favorite================

  RxBool isFavorite = false.obs;

  removeFavorite({required String id}) async {
    isFavorite.value = true;
    refresh();
    Map<String, String> body = {

    };
    var response = await ApiClient.postData(
      ApiUrl.addFavorite(id: id),jsonEncode(body)

    );
    if (response.statusCode == 200) {
     getFavorite();
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isFavorite.value = false;
    refresh();
  }


 @override
  void onInit() {
    getFavorite();
    super.onInit();
  }
}
