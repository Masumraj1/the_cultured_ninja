import 'package:final_movie/view/screen/actor_details/actor_details.dart';
import 'package:final_movie/view/screen/actor_movie/actor_movie.dart';
import 'package:final_movie/view/screen/all_movies/all_movies.dart';
import 'package:final_movie/view/screen/authentication/forget_otp/forget_otp.dart';
import 'package:final_movie/view/screen/authentication/forget_password/forget_password.dart';
import 'package:final_movie/view/screen/authentication/reset_password/reset_password.dart';
import 'package:final_movie/view/screen/authentication/select_streaming_screen/select_streaming_screen.dart';
import 'package:final_movie/view/screen/authentication/sign_in_screen/sign_in_screen.dart';
import 'package:final_movie/view/screen/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:final_movie/view/screen/authentication/spin_screen/spin_screen.dart';
import 'package:final_movie/view/screen/authentication/successfully_screen/successfully_screen.dart';
import 'package:final_movie/view/screen/favorite_screen/favorite_screen.dart';
import 'package:final_movie/view/screen/filter_screen/filter_screen.dart';
import 'package:final_movie/view/screen/filter_screen/filter_selected_genres_screen/filter_selected_genres_screen.dart';
import 'package:final_movie/view/screen/history_screen/history_screen.dart';
import 'package:final_movie/view/screen/home_screen/home_screen.dart';
import 'package:final_movie/view/screen/movie_details/movie_details.dart';
import 'package:final_movie/view/screen/notification_screen/notification_screen.dart';
import 'package:final_movie/view/screen/onbording_screen/onbording_screen.dart';
import 'package:final_movie/view/screen/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:final_movie/view/screen/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:final_movie/view/screen/profile_screen/profile_screen.dart';
import 'package:final_movie/view/screen/search_screen/search_screen.dart';
import 'package:final_movie/view/screen/setting_screen/change_password_screen/change_password_screen.dart';
import 'package:final_movie/view/screen/setting_screen/setting_screen.dart';
import 'package:final_movie/view/screen/splash_screen/splash_screen.dart';
import 'package:final_movie/view/screen/studios_details_screen/studios_details_screen.dart';
import 'package:final_movie/view/screen/studios_screen/studios_screen.dart';
import 'package:final_movie/view/screen/terms_and_condition_screen/terms_and_condition.dart';
import 'package:final_movie/view/screen/top_rating_movies/top_rating_movies.dart';
import 'package:get/get.dart';


class AppRoute {
  AppRoute._();
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

  ///=======================EditProfile=====================
static const String editProfileScreen = '/EditProfileScreen';


static const String searchScreen = '/SearchScreen';
static const String favoriteScreen = '/FavoriteScreen';
static const String topRatingMovies = '/TopRatingMovies';
static const String filterScreen = '/FilterScreen';
static const String studiosScreen = '/StudiosScreen';
static const String studiosDetailsScreen = '/StudiosDetailsScreen';
static const String movieDetails = '/MovieDetails';
static const String allMovies = '/AllMovies';
static const String actorDetails = '/ActorDetails';
static const String actorMovie = '/ActorMovie';
static const String profileScreen = '/ProfileScreen';
static const String filterSelectedGenresScreen = '/filterSelectedGenresScreen';
static const String privacyPolicyScreen = '/PrivacyPolicyScreen';
static const String termsAndCondition = '/TermsAndCondition';
static const String selectStreamingScreen = '/SelectStreamingScreen';
static const String spinScreen = '/SpinScreen';
static const String historyScreen = '/HistoryScreen';






  static List<GetPage> routes = [
    ///==================== Initial Routes ====================
    GetPage(name: splashScreen, page: () => const SplashScreen()),


    ///==========================OnBoarding Screen============
    GetPage(name: onBoardingPage, page: () =>   OnBoardingPage()),

    ///============================Authentication Screen========
    GetPage(name: signInScreen, page: () =>  SignInScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: forgetPassword, page: () =>   ForgetPassword()),
    GetPage(name: forgetOtp, page: () =>   const ForgetOtp()),
    GetPage(name: resetPassword, page: () =>   ResetPassword()),
    GetPage(name: successfullyScreen, page: () =>  const SuccessfullyScreen()),

    ///=============================HomeScreen===================
    GetPage(name: homeScreen, page: () =>    HomeScreen()),
    GetPage(name: settingScreen, page: () =>     SettingScreen()),
    GetPage(name: changePasswordScreen, page: () =>     ChangePasswordScreen()),
    GetPage(name: notificationScreen, page: () =>     NotificationScreen()),
    GetPage(name: privacyPolicyScreen, page: () =>    const PrivacyPolicyScreen()),
    GetPage(name: termsAndCondition, page: () =>    const TermsAndCondition()),
    GetPage(name: historyScreen, page: () =>     HistoryScreen()),

    ///==============================editProfile=====================
    GetPage(name: editProfileScreen, page: () =>     EditProfileScreen()),





    GetPage(name: searchScreen, page: () =>      SearchScreen()),
    GetPage(name: favoriteScreen, page: () =>      FavoriteScreen()),
    GetPage(name: topRatingMovies, page: () =>      TopRatingMovies()),
    GetPage(name: filterScreen, page: () =>      FilterScreen()),
    GetPage(name: studiosScreen, page: () =>      StudiosScreen()),
    GetPage(name: studiosDetailsScreen, page: () =>      StudiosDetailsScreen()),
    GetPage(name: movieDetails, page: () =>      MovieDetails()),
    GetPage(name: allMovies, page: () =>       AllMovies()),
    GetPage(name: actorDetails, page: () =>       ActorDetails()),
    GetPage(name: actorMovie, page: () =>        ActorMovie()),
    GetPage(name: profileScreen, page: () =>         ProfileScreen()),
    GetPage(name: filterSelectedGenresScreen, page: () => const FilterSelectedGenresScreen()),
    GetPage(name: selectStreamingScreen, page: () =>  SelectStreamingScreen()),
    GetPage(name: spinScreen, page: () =>   SpinScreen()),
  ];
}