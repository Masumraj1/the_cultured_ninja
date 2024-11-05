import 'dart:io';

class AppConstants {
  static String bearerToken = "BearerToken";
  static String isPayment = "isPayment";
  static String resetToken = "BearerToken";
  // static String userId = "UserId";
  static String onBoard = "Onboard";
  static String isRememberMe = "isRememberMe";
  static String stripePublishableKey =
      "pk_test_51POthLRvVQ0C2mQsfgSDWtXVQOtisKTZTCP46fiZjULEyyB0ff08Ny9JfZGnw9fM8ZhURwpdTOyA69dxp0bDNr6U00NVCfO3ak";
  /// <====================== All Response Message Static==============================>
  static String bannerAdsId = Platform.isAndroid
      ? 'ca-app-pub-9098800682156327/5573978693'
      : 'ca-app-pub-9098800682156327/7281710406';

  static String interstitialAdsId = Platform.isAndroid
      ? 'ca-app-pub-9098800682156327~8268085481'
      : 'ca-app-pub-9098800682156327/4843249328';


  static String successfull = "Request Successfull";
  static String error = "Oops, something went wrong";
  static String profileID = "profileID";
  static String userStatus = "userStatus";
  static String rememberMe = "rememberMe";
  ///=============================================Remove this ========================

  static String movieImage = "https://www.imax.com/_next/image?url=https%3A%2F%2Fimages.ctfassets.net%2Fc4ucztjx9pmu%2F5ldp5ssgX09c8l0Coa15OC%2F947b02a9e3568199d8088b6e18de0f4a%2FPM1093_US_EA_Scl_1080x1600_px_ENG_D_R_V1_R1.jpg&w=1920&q=75";
  static String onlineImage =
      "https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg?size=626&ext=jpg&ga=GA1.1.1141335507.1717977600&semt=sph";

}

enum Status { loading, error, completed, internetError }

