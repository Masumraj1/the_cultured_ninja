
import 'package:final_movie/model/filter_model/filter_model.dart';
import 'package:final_movie/model/streaming_actor_model/streaming_actor_model.dart';
import 'package:final_movie/model/streaming_model/movie_genre_model.dart';
import 'package:final_movie/model/streaming_model/select_streaming_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class StreamingController extends GetxController {
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///====================================Get All Studio===========
  RxList<StreamingDataSelect> streamList = <StreamingDataSelect>[].obs;

  getAllStudio() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.studioSelect);

    if (response.statusCode == 200) {
      streamList.value = List<StreamingDataSelect>.from(
          response.body["data"].map((x) => StreamingDataSelect.fromJson(x)));

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
  // RxBool isUpdate = false.obs;
  //
  // Future<void> genreUpdate({Map<String, String>? header,
  //   required TextEditingController genreController}) async {
  //   if (genreController.text.isEmpty) {
  //     toastMessage(message: "Genre cannot be empty");
  //     return; // Exit if genre is empty
  //   }
  //
  //   isUpdate.value = true;
  //   update(); // Notify listeners that state has changed
  //
  //   try {
  //     var body = {
  //       "genres": jsonEncode([genreController.text]),
  //     };
  //
  //     var response = await ApiClient.patchMultipartData(
  //       ApiUrl.editProfile,
  //       body,
  //       haveImage: false
  //
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // toastMessage(message: response.body["message"]);
  //       Get.toNamed(AppRoute.homeScreen); // Navigate to home screen
  //     } else {
  //       ApiChecker.checkApi(response); // Handle other response codes
  //     }
  //   } catch (e) {
  //     debugPrint("Error occurred: $e"); // Print the error for debugging
  //   } finally {
  //     isUpdate.value = false; // Reset loading state
  //     update(); // Notify listeners that state has changed
  //   }
  // }

  ///===================================Genre Filtering===================
  RxString selectedGenre =
      ''.obs; // Use a reactive String to track selected genre

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

  RxList<StreamingActorSelectList> streamingActorSelectList =
      <StreamingActorSelectList>[].obs;
  getMultiMovie({required String selectedActorId, required List<String> selectedProviderIds}) async {
    setRxRequestStatus(Status.loading);
    refresh();

    // Join the list of provider IDs into a single string separated by commas
    String providerIds = selectedProviderIds.join(',');

    var response = await ApiClient.getData(
        ApiUrl.multiSelectedApi(actorId: selectedActorId, streamingId: providerIds));

    if (response.statusCode == 200) {
      streamingActorSelectList.value = List<StreamingActorSelectList>.from(
          response.body["data"].map((x) => StreamingActorSelectList.fromJson(x)));
      print('StreamingActorSelectList=========================="${streamingActorSelectList.length}"');

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

  // getMultiMovie({required String selectedActorId , required String selectedProviderIds}) async {
  //   setRxRequestStatus(Status.loading);
  //   refresh();
  //   var response = await ApiClient.getData(
  //       ApiUrl.multiSelectedApi(actorId: selectedActorId , streamingId: selectedProviderIds));
  //
  //   if (response.statusCode == 200) {
  //     streamingActorSelectList.value = List<StreamingActorSelectList>.from(
  //         response.body["data"]
  //             .map((x) => StreamingActorSelectList.fromJson(x)));
  //     print(
  //         'StreamingActorSelectList=========================="${streamingActorSelectList.length}"');
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

  @override
  void onInit() {
    getAllStudio();
    getAllGenre();
    super.onInit();
  }
}
