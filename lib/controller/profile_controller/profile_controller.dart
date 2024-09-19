import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

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




}