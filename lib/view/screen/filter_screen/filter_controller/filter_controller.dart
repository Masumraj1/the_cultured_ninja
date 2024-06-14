import 'package:get/get.dart';

class FilterController extends GetxController{

  ///============================Selected genre==================
  var selectedGenres = <String>[].obs;

  void toggleGenreSelection(String genre) {
    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
    } else {
      selectedGenres.add(genre);
    }
  }



}