import 'dart:convert';

import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/model/studio/studio_model.dart';
import 'package:final_movie/model/studio_details_model/studio_details_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class StudiosController extends GetxController {
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  Rx<StudioDetails> studioModel = StudioDetails().obs;

  studioDetails({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getStudioDetails(id: id));

    if (response.statusCode == 200) {
      studioModel.value = StudioDetails.fromJson(response.body["data"]);
      isFollowed.value = studioModel.value.details?.isFollowed ?? false;

      print(
          'Studio ========================="${response.body['data']['details']}"');
      print(
          'relatedStudios========================="${studioModel.value.relatedStudios?.length}"');

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

  ///===============================Add Flow =================

  var isFollowed = false.obs;

  Future<bool> toggleWatched(String studioId) async {
    isFollowed.value = !isFollowed.value;

    // Optionally: Call an API to persist this watched state
    return await addFollow(id: studioId);
  }

  RxBool isTap = false.obs;

  Future<bool> addFollow({required String id}) async {
    isTap.value = true;
    refresh();
    Map<String, String> body = {"studioId": id, "type": "studio"};
    var response = await ApiClient.postData(ApiUrl.addFlow, jsonEncode(body));
    if (response.statusCode == 201) {
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
}
