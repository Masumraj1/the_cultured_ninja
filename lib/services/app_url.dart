class ApiUrl {
  ///=================================This is baseUrl==============================================>
  static const baseUrl = "http://103.161.9.133:7000";
  static const networkImageUrl = "http://103.161.9.133:7000/";

  ///================================= User Authentication url==========================
  static const signupAuth = "/auth/sign-up";
  static const signInAuth = "/auth/sign-in";
  static const verifyCOde = "/auth/verify-code";
  static const forgotPasswordAuth = "/auth/send-verify-email";
  static const resetPasswordAuth = "/auth/reset-password";




  static const profile = "/auth/profile";
  static const editProfile = "/auth/update-user";
  static const changePassword = "/auth/change-password";
  static const deleteAccount = "/auth/delete-account";
  static const terms = "/settings/get-settings/terms";
  static const privacy = "/settings/get-settings/privacy";
  static const getMovieGenre = "/movie-type/movie-type/tv";
  static const bannerMovie = "/movie/all-movies?banner=true";
  static const getMovies = "/movie/all-movies?type=movie";
  static const getTv = "/movie/all-movies?type=tv";
  static String movieDetails({required String id}) {
    return "/movie/get-movie-details/$id";
  }

  ///========================Studio==============
  static const getAllStudio = "/studio/get-studio";
  static const search = "/movie/all-movies?search";


  ///===========================Favorite===============
  static const getFavorite = "/favorite/get-favorite";
  static String addFavorite({required String id}) {
    return "/favorite/add-favorite/$id";
  }


}
