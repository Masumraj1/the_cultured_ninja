import 'package:final_movie/controller/admob_controller/admob_controller.dart';
import 'package:final_movie/controller/authentication_controller/authentication_controller.dart';
import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/controller/favorite_controller/favorite_controller.dart';
import 'package:final_movie/controller/filter_controller/filter_controller.dart';
import 'package:final_movie/controller/following_controller/following_controller.dart';
import 'package:final_movie/controller/genarel_controller/genarel_controller.dart';
import 'package:final_movie/controller/global_controller/global_controller.dart';
import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/controller/movie_details_controller/movie_details_controller.dart';
import 'package:final_movie/controller/notification_controller/notification_controller.dart';
import 'package:final_movie/controller/payment_controller/payment_controller.dart';
import 'package:final_movie/controller/profile_controller/profile_controller.dart';
import 'package:final_movie/controller/streaming_controller/streaming_controller.dart';
import 'package:final_movie/controller/studios_controller/studios_controller.dart';
import 'package:get/get.dart';


class DependencyInjection extends Bindings {
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
    Get.lazyPut(() => GeneralController(), fenix: true);
    Get.lazyPut(() => StreamingController(), fenix: true);
    Get.lazyPut(() => MovieDetailsController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => AdmobController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => GlobalController(), fenix: true);

  }
}