import 'package:final_movie/view/screen/authentication/authentication_controller/authentication_controller.dart';
import 'package:get/get.dart';


class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController(), fenix: true);

  }
}