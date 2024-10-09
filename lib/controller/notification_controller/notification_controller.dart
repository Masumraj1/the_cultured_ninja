import 'package:final_movie/model/notification_model/notification_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  ///==============================Notification==================
  RxList<NotificationData> notificationList = <NotificationData>[].obs;

  getNotification() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.notificationList);

    if (response.statusCode == 200) {
      notificationList.value = List<NotificationData>.from(
          response.body["data"].map((x) => NotificationData.fromJson(x)));
      print('NotificationList=========================="${notificationList.length}"');
      // print('NotificationList=========================="${response.body['data']['title']}"');

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
    getNotification();
    super.onInit();
  }
}