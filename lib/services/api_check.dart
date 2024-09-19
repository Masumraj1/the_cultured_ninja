import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/shared_prefe/shared_prefe.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:get/get.dart';



class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode == 401) {
      await SharePrefsHelper.remove(AppConstants.bearerToken);

      await SharePrefsHelper.setBool(AppConstants.rememberMe, false);

      Get.offAllNamed(AppRoute.signInScreen);
    } else {
      showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
    }
  }
}
