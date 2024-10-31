import 'dart:async';
import 'dart:convert';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/model/calender_model/calender_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import '../../services/api_client.dart';

class CalendarController extends GetxController {

  // List of dates selected in the calendar
  var dates = <DateTime?>[DateTime.now()].obs;

  // Observable for the currently selected date
  var selectedDate = DateTime.now().obs;

  // RxBool to track if a calendar entry is being added
  RxBool isAdded = false.obs;



  // Method to update the selected dates
  void updateDates(List<DateTime?> newDates) {
    dates.value = newDates;
    if (newDates.isNotEmpty) {
      selectedDate.value = newDates.first!; // Update selectedDate to the first date
    }
  }

  ///=================== Method to add a movie to the calendar======================
  Future<void> addedCalender({required String id, required String date}) async {
    isAdded.value = true; // Set loading state

    // Prepare the request body
    Map<String, String> body = {
      "movie": id,
      "date": date // Expecting the date to be formatted as "dd-MM-yyyy"
    };

    // Send the request to add the calendar entry
    var response = await ApiClient.postData(
      ApiUrl.addedCalender,
      jsonEncode(body),
    );

    // Handle the response
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]); // Show success message
      Get.back(); // Close the dialog or go back
    } else {
      ApiChecker.checkApi(response); // Handle API error
    }

    isAdded.value = false; // Reset loading state
  }



  ///======================== Method to fetch calendar data====================
  var title = "Loading...".obs;
  var imageUrl = "".obs; // Add imageUrl to store image data
  Timer? _timer;
  int currentIndex = 0;

  Rx<CalenderData> calenderModel = CalenderData().obs;

  Future<void> getCalender() async {
    setRxRequestStatus(Status.loading); // Set loading status

    var response = await ApiClient.getData(ApiUrl.getCalenderMovie); // Fetch calendar data

    if (response.statusCode == 200) {
      calenderModel.value = CalenderData.fromJson(response.body["data"]);

      // Assuming calenderModel.value.movies contains the list of banner data
      if (calenderModel.value.movies != null && calenderModel.value.movies!.isNotEmpty) {
        currentIndex = 0;

        // Set initial title and image URL
        title.value = calenderModel.value.movies![currentIndex].title ?? "No Title";
        imageUrl.value = calenderModel.value.movies![currentIndex].poster ?? ""; // Store image URL
        updateWidgetContent();

        // Setup periodic timer to update title and image
        _timer?.cancel(); // Cancel previous timer if any
        _timer = Timer.periodic(Duration(seconds: 7), (timer) {
          currentIndex = (currentIndex + 1) % calenderModel.value.movies!.length;
          title.value = calenderModel.value.movies![currentIndex].title ?? "No Title";
          imageUrl.value = calenderModel.value.movies![currentIndex].poster ?? ""; // Update image URL
          updateWidgetContent();
        });
      }

      // Log data for debugging
      print('CalenderMovieList=========================="${calenderModel.value.movies?.length}"');
      print('DateList=========================="${calenderModel.value.dates?.length}"');
      setRxRequestStatus(Status.completed); // Set completed status
    } else {
      // Handle errors
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError); // Handle no internet error
      } else {
        setRxRequestStatus(Status.error); // Handle general error
      }
      ApiChecker.checkApi(response); // Check API response
    }
  }

  void updateWidgetContent() async {
    print("==================Updating widget with title: ${title.value} "
        " imageUrl:==================================== ${imageUrl.value}"); // Log title and image URL

    await HomeWidget.saveWidgetData<String>('api_title', title.value);
    await HomeWidget.saveWidgetData<String>('api_image_url', imageUrl.value); // Save image URL
    await HomeWidget.updateWidget(
      name: 'HomeScreenWidgetProvider',
      iOSName: 'HomeScreenWidgetProvider',
    );
  }


  // Method to set the status of the API request
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  // Lifecycle method to fetch calendar data on initialization
  @override
  void onInit() {
    getCalender(); // Fetch calendar data
    super.onInit();
  }

  // Observable to track the status of the request
  final rxRequestStatus = Status.loading.obs;
}
