import 'package:final_movie/view/screen/authentication/signIn_screen/sign_in_screen.dart';
import 'package:final_movie/view/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';


class AppRoute {
  ///==================== Initial Routes ====================
  static const String splashScreen = "/splash_screen";
  static const String signInScreen = "/signInScreen";

  static List<GetPage> routes = [
    ///==================== Initial Routes ====================

    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),

  ];
}