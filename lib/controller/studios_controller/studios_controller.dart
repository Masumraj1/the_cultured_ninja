import 'package:final_movie/model/studio/studio_model.dart';
import 'package:final_movie/model/studio_details_model/studio_details_model.dart';
import 'package:final_movie/services/api_check.dart';
import 'package:final_movie/services/api_client.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';

class StudiosController extends GetxController {




  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  Rx<StudioDetails> studioModel = StudioDetails().obs;

  studioDetails({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getStudioDetails(id: id));

    if (response.statusCode == 200) {
      studioModel.value = StudioDetails.fromJson(response.body["data"]);

      print('Studio ========================="${response.body['data']['details']}"');
      print(
          'relatedStudios========================="${studioModel.value.relatedStudios?.length}"');


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
