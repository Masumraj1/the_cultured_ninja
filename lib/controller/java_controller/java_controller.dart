// // controller/java_controller.dart
//
// import 'package:final_movie/model/actor_details_model/actor_details_model.dart';
// import 'package:final_movie/services/api_check.dart';
// import 'package:final_movie/services/api_client.dart';
// import 'package:final_movie/services/app_url.dart';
// import 'package:final_movie/utils/app_const/app_const.dart';
// import 'package:get/get.dart';
// import 'package:home_widget/home_widget.dart';
//
//
// class JavaController extends GetxController {
//   var title = "Loading...".obs; // Observable title
//   var isLoading = true.obs; // Loading state
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTitle(); // Fetch title on initialization
//   }
//
//
//
//   final rxRequestStatus = Status.loading.obs;
//
//   void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
//
//   Rx<ActorDetailsData> actorDetails = ActorDetailsData().obs;
//
//   fetchTitle({required String id}) async {
//     setRxRequestStatus(Status.loading);
//     refresh();
//     var response = await ApiClient.getData(ApiUrl.actorDetails(id: id));
//
//     if (response.statusCode == 200) {
//       actorDetails.value = ActorDetailsData.fromJson(response.body["data"]);
//       title.value = data['title'] ?? "No Title";
//
//       // Save title for HomeWidget to access
//       await HomeWidget.saveWidgetData<String>('api_title', title.value);
//       await HomeWidget.updateWidget(
//         name: 'HomeScreenWidgetProvider',
//         iOSName: 'HomeScreenWidgetProvider',
//       );
//       print(
//           'Upcoming list ========================="${actorDetails.value.upcomingMovies?.length}"');
//       // print('Upcoming movie Id ========================="${response.body['data']['upcoming_movies']['id']}"');
//
//       setRxRequestStatus(Status.completed);
//       refresh();
//     } else {
//       if (response.statusText == ApiClient.noInternetMessage) {
//         setRxRequestStatus(Status.internetError);
//       } else {
//         setRxRequestStatus(Status.error);
//       }
//       ApiChecker.checkApi(response);
//     }
//   }
// }
