import 'package:final_movie/view/screen/authentication/forget_otp/forget_otp.dart';
import 'package:final_movie/view/screen/authentication/forget_password/forget_password.dart';
import 'package:final_movie/view/screen/authentication/reset_password/reset_password.dart';
import 'package:final_movie/view/screen/authentication/signIn_screen/sign_in_screen.dart';
import 'package:final_movie/view/screen/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:final_movie/view/screen/authentication/successfully_screen/successfully_screen.dart';
import 'package:final_movie/view/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';


class AppRoute {
  ///==================== Initial Routes ====================
  static const String splashScreen = "/splash_screen";
  static const String signInScreen = "/signInScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String forgetPassword = "/ForgetPassword";
  static const String forgetOtp = "/ForgetOtp";
  static const String resetPassword = "/ResetPassword";
  static const String successfullyScreen = "/SuccessfullyScreen";

  static List<GetPage> routes = [
    ///==================== Initial Routes ====================

    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: signInScreen, page: () =>  SignInScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: forgetPassword, page: () =>  const ForgetPassword()),
    GetPage(name: forgetOtp, page: () =>  const ForgetOtp()),
    GetPage(name: resetPassword, page: () =>  const ResetPassword()),
    GetPage(name: successfullyScreen, page: () =>  const SuccessfullyScreen()),

  ];
}