import 'dart:io';

import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/model/profile_model/profile_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///============================Image picker method================
  RxString image = "".obs;

  Rx<File> imageFile = File("").obs;

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      image.value = getImages.path;
    }
  }

  ///===============================GetProfile Method=========================

  Rx<ProfileData> profileModel = ProfileData().obs;

  getProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.profile);
    setRxRequestStatus(Status.completed);
    if (response.statusCode == 200) {
      profileModel.value = ProfileData.fromJson(response.body["data"]);
      setTextFieldValue();
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

  ///=========================================Edit Profile==========================
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxBool isUpdateLoading = false.obs;

  Future<void> userProfileEdit({Map<String, String>? header}) async {
    isUpdateLoading.value = true;
    update();
    try {
      var body = {
        "name": nameController.text,
        "address": addressController.text,
        "phone": phoneController.text,
      };
      var response = await ApiClient.patchMultipartData(
          ApiUrl.editProfile, body,
          haveImage: true,
          multipartBody: [
            MultipartBody("img", File(image.value)),
          ]);

      if (response.statusCode == 200) {
        getProfile();
        refresh();
        Get.back();
        isUpdateLoading.value = false;
        refresh();
        toastMessage(message: response.body["message"]);
      } else {
        isUpdateLoading.value = false;
        refresh();
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint("============> $e");
    }
  }


  setTextFieldValue(){
    nameController.text=profileModel.value.name.toString();
    phoneController.text=profileModel.value.phone.toString();
    emailController.text=profileModel.value.email.toString();
    addressController.text=profileModel.value.address??"";
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
