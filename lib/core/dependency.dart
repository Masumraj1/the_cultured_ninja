import 'package:final_movie/view/screen/authentication/authentication_controller/authentication_controller.dart';
import 'package:final_movie/view/screen/favorite_screen/favorite_controller/favorite_controller.dart';
import 'package:final_movie/view/screen/following_screen/following_controller/following_controller.dart';
import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/screen/profile_screen/profile_controller/profile_controller.dart';
import 'package:get/get.dart';


class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => FollowingController(), fenix: true);

  }
}