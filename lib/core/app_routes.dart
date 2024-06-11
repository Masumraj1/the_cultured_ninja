import 'package:final_movie/view/screen/authentication/forget_otp/forget_otp.dart';
import 'package:final_movie/view/screen/authentication/forget_password/forget_password.dart';
import 'package:final_movie/view/screen/authentication/reset_password/reset_password.dart';
import 'package:final_movie/view/screen/authentication/signIn_screen/sign_in_screen.dart';
import 'package:final_movie/view/screen/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:final_movie/view/screen/authentication/successfully_screen/successfully_screen.dart';
import 'package:final_movie/view/screen/history_screen/history_screen.dart';
import 'package:final_movie/view/screen/home_screen/home_screen.dart';
import 'package:final_movie/view/screen/notification_screen/notification_screen.dart';
import 'package:final_movie/view/screen/onbording_screen/onbording_screen.dart';
import 'package:final_movie/view/screen/setting_screen/change_password_screen/change_password_screen.dart';
import 'package:final_movie/view/screen/setting_screen/setting_screen.dart';
import 'package:final_movie/view/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';


class AppRoute {
  ///==================== Initial Routes ====================
  static const String splashScreen = "/splash_screen";

  ///==========================OnBoarding Screen============
  static const String onBoardingPage = "/OnBoardingPage";

  ///============================Authentication Screen========
  static const String signInScreen = "/signInScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String forgetPassword = "/ForgetPassword";
  static const String forgetOtp = "/ForgetOtp";
  static const String resetPassword = "/ResetPassword";
  static const String successfullyScreen = "/SuccessfullyScreen";

  ///=============================HomeScreen===================
  static const String homeScreen = "/HomeScreen";
  static const String settingScreen = "/SettingScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String historyScreen = "/HistoryScreen";







  static List<GetPage> routes = [
    ///==================== Initial Routes ====================
    GetPage(name: splashScreen, page: () => const SplashScreen()),


    ///==========================OnBoarding Screen============
    GetPage(name: onBoardingPage, page: () =>   OnBoardingPage()),

    ///============================Authentication Screen========
    GetPage(name: signInScreen, page: () =>  SignInScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: forgetPassword, page: () =>  const ForgetPassword()),
    GetPage(name: forgetOtp, page: () =>  const ForgetOtp()),
    GetPage(name: resetPassword, page: () =>  const ResetPassword()),
    GetPage(name: successfullyScreen, page: () =>  const SuccessfullyScreen()),

    ///=============================HomeScreen===================
    GetPage(name: homeScreen, page: () =>    HomeScreen()),
    GetPage(name: settingScreen, page: () =>    const SettingScreen()),
    GetPage(name: changePasswordScreen, page: () =>     ChangePasswordScreen()),
    GetPage(name: notificationScreen, page: () =>    const NotificationScreen()),
    GetPage(name: historyScreen, page: () =>    const HistoryScreen()),

  ];
}