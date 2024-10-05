import 'package:final_movie/model/movie_details.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class MovieDetailsController extends GetxController{
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  var isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  RxBool isTap = false.obs;

  void toggleTap() {
    isTap.value = !isTap.value;
  }
  ///====================================Get Details================
  Rx<DetailsData> moviesDetailsModel = DetailsData().obs;

  movieDetails({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.movieDetails(id: id));

    if (response.statusCode == 200) {
      moviesDetailsModel.value =
          DetailsData.fromJson(response.body["data"]);


      print('data fetch==================="${response.body["data"]}"');
      print('backdrop_path==================="${response.body["data"]['details']["backdrop_path"]}"');
      print('actorList==================="${moviesDetailsModel.value.actors?.length}');
      print('SimilarMovies==================="${moviesDetailsModel.value.similarMovies?.length}');


      // print('Length================="${actorList.length}"');

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
}