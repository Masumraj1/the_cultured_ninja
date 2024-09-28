import 'package:final_movie/model/all_streaming_model.dart';
import 'package:final_movie/model/movie_genre_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
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

  ///====================================Get All Studio===========
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


  @override
  void onInit() {
    getAllStudio();
    getAllGenre();
    super.onInit();
  }
}