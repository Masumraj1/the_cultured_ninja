class AppConstants {
  static String bearerToken = "BearerToken";
  // static String userId = "UserId";
  static String onBoard = "Onboard";
  static String isRememberMe = "isRememberMe";

  /// <====================== All Response Message Static==============================>

  static String successfull = "Request Successfull";
  static String error = "Oops, something went wrong";
  static String profileID = "profileID";
  static String userStatus = "userStatus";
  static String rememberMe = "rememberMe";
  static String movieImage = "https://www.imax.com/_next/image?url=https%3A%2F%2Fimages.ctfassets.net%2Fc4ucztjx9pmu%2F5ldp5ssgX09c8l0Coa15OC%2F947b02a9e3568199d8088b6e18de0f4a%2FPM1093_US_EA_Scl_1080x1600_px_ENG_D_R_V1_R1.jpg&w=1920&q=75";
  static String onlineImage =
      "https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg?size=626&ext=jpg&ga=GA1.1.1141335507.1717977600&semt=sph";
}

enum Status { loading, error, completed, internetError }