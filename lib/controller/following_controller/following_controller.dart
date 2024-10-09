import 'package:final_movie/model/flow_model/flow_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class FollowingController extends GetxController{
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }



  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  Rx<FlowData> flowData = FlowData().obs;

  getFlowing() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getFlow);
    setRxRequestStatus(Status.completed);
    if (response.statusCode == 200) {
      flowData.value = FlowData.fromJson(response.body["data"]);

      print('ActorList=========================="${flowData.value.actors?.length}"');
      print('StudioList=========================="${flowData.value.studios?.length}"');

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
   getFlowing();
    super.onInit();
  }
}