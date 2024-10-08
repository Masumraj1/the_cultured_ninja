import 'dart:convert';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/model/history_model/history_model.dart';
import 'package:final_movie/model/privacy_model.dart';
import 'package:final_movie/model/terms_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class GeneralController extends GetxController {
  ///========================================================Change Password=========================
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool isChangeLoading = false.obs;

  changePassword() async {
    isChangeLoading.value = true;
    refresh();
    Map<String, String> body = {
      "old_Password": oldPasswordController.text,
      "password": passwordController.text,
      "confirm_password": confirmPasswordController.text
    };

    var response = await ApiClient.patchData(
      ApiUrl.changePassword,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      oldPasswordController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      Get.back();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isChangeLoading.value = false;
  }

  ///================================Terms And privacy==================
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///===================================GetTerms=========================
  TermsModel termsModel = TermsModel();
  getTerms() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.terms);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      termsModel = TermsModel.fromJson(response.body);

      print('Value========================"${termsModel.data?.value}"');
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///===================================GetTerms=========================
  PrivacyModel privacyModel = PrivacyModel();
  getPrivacy() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.privacy);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      privacyModel = PrivacyModel.fromJson(response.body);

      print('body========================"${response.body}');
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }



///==============================History==================
  RxList<HistoryData> historyList = <HistoryData>[].obs;

  getHistory() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getHistory);

    if (response.statusCode == 200) {
      historyList.value = List<HistoryData>.from(
          response.body["data"].map((x) => HistoryData.fromJson(x)));
      print('historyList=========================="${historyList.length}"');

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

   ///==============================Remove History==============
  RxBool isHistory = false.obs;

  removeHistory({required String id}) async {
    isHistory.value = true;
    refresh();
    Map<String, String> body = {

    };
    var response = await ApiClient.postData(
        ApiUrl.addHistory(id: id),jsonEncode(body)

    );
    if (response.statusCode == 200) {
        getHistory();
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isHistory.value = false;
    refresh();
  }


  @override
  void onInit() {
    getPrivacy();
    getTerms();
    getHistory();
    super.onInit();
  }

}
