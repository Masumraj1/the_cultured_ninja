import 'package:final_movie/view/screen/authentication/authentication_controller/authentication_controller.dart';
import 'package:final_movie/view/screen/calender_screen/calendar_controller/calendar_controller.dart';
import 'package:final_movie/view/screen/favorite_screen/favorite_controller/favorite_controller.dart';
import 'package:final_movie/view/screen/filter_screen/filter_controller/filter_controller.dart';
import 'package:final_movie/view/screen/following_screen/following_controller/following_controller.dart';
import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/screen/profile_screen/profile_controller/profile_controller.dart';
import 'package:final_movie/view/screen/studios_screen/studios_controller/studios_controller.dart';
import 'package:get/get.dart';


class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => FollowingController(), fenix: true);
    Get.lazyPut(() => CalendarController(), fenix: true);
    Get.lazyPut(() => FilterController(), fenix: true);
    Get.lazyPut(() => StudiosController(), fenix: true);

  }
}