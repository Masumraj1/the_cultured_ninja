class ApiUrl {
  ///=================================This is baseUrl==============================================>
  static const baseUrl = "http://174.138.74.126:7000";
  static const networkImageUrl = "http://174.138.74.126:7000/";


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
  static String actorDetails({required String id}) {
    return "/actor/get-actor-details/$id";
  }

  ///========================Studio==============
  static const getAllStudio = "/studio/get-studio";
  static const studioSelect = "/studio/top-studio";
  static const search = "/movie/all-movies?search";
  static String getStudioDetails({required String id}) {
    return "/studio/get-studio/$id";
  }

  static String multiSelectedApi({required String actorId,required String streamingId}) {
    return "/movie/spin-data?actorId=$actorId&studio_id=$streamingId";
  }

  static String filterMovie({required String id}) {
    return "/movie/all-movies?genre_id=$id";
  }


  ///====================Add Flow================
  static const addFlow = "/follow/add-follow";
  static const getFlow = "/follow/get-follow";

  ///=====================calender==============
  static const addedCalender = "/calender/add-to-calender";
  static const getCalenderMovie = "/calender/get-calendered-movie";


  ///===========================Favorite===============
  static const getFavorite = "/favorite/get-favorite";
  static String addFavorite({required String id}) {
    return "/favorite/add-favorite/$id";
  }



  ///=========================Notification ===============
  static const notificationList = "/notification/get-notifications";


  ///===========================History===============
  static const getHistory = "/history/get-history";
  static String addHistory({required String id}) {
    return "/history/add-history/$id";
  }


  ///==========================Payment=================
  static const createPaymentIntent = "/payment/create-payment-intent";
  static const savePayment = "/payment/save-payment";


}
