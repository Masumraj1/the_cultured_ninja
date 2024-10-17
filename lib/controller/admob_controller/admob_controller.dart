// import 'package:final_movie/helpar/toast_message/toast_message.dart';
// import 'package:final_movie/utils/app_const/app_const.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdmobAccountController extends GetxController {
//   /// Banner Ad
//   late BannerAd bannerAd;
//   RxBool isBannerAdReady = false.obs; // Observable to track banner ad readiness
//
//   /// Interstitial Ad
//   RxBool isFullPage = false.obs;
//   InterstitialAd? interstitialAd;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeBannerAd();
//   }
//
//   /// ================================== Banner Ad =====================
//   void _initializeBannerAd() {
//     bannerAd = BannerAd(
//       adUnitId: 'ca-app-pub-9098800682156327/7281710406',
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (_) {
//           isBannerAdReady.value = true;
//           debugPrint('Banner Ad loaded.====================================');
//         },
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose(); // Dispose of the ad when it fails to load
//           debugPrint('Banner Ad failed to load:=============================== $error');
//           isBannerAdReady.value = false;
//         },
//       ),
//     );
//
//     bannerAd.load(); // Load the banner ad
//   }
//
//   /// ================================= Interstitial Ad ===========================
//   void initializeFullPageAd({required VoidCallback adsCloseOnTap}) async {
//     isFullPage.value = true;
//     refresh();
//
//     try {
//       await InterstitialAd.load(
//         adUnitId: AppConstants.interstitialAdsId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (ad) {
//             interstitialAd = ad;
//             interstitialAd!.show();
//
//             ad.fullScreenContentCallback = FullScreenContentCallback(
//               onAdShowedFullScreenContent: (ad) {
//                 debugPrint("Interstitial Ad showed full screen.");
//               },
//               onAdImpression: (ad) {
//                 debugPrint("Interstitial Ad impression logged.");
//               },
//               onAdFailedToShowFullScreenContent: (ad, err) {
//                 ad.dispose();
//                 isFullPage.value = false;
//                 refresh();
//                 debugPrint("Interstitial Ad failed to show: $err");
//               },
//               onAdDismissedFullScreenContent: (ad) {
//                 ad.dispose();
//                 isFullPage.value = false;
//                 refresh();
//                 debugPrint("Interstitial Ad dismissed.");
//
//                 // Execute the callback when the ad is dismissed
//                 adsCloseOnTap();
//               },
//               onAdClicked: (ad) {
//                 debugPrint("Interstitial Ad clicked.");
//               },
//             );
//           },
//           onAdFailedToLoad: (error) {
//             toastMessage(message: error.message);
//             isFullPage.value = false;
//             refresh();
//             debugPrint("Interstitial Ad failed to load: ${error.message}");
//           },
//         ),
//       );
//     } catch (err) {
//       isFullPage.value = false;
//       refresh();
//       debugPrint("Error initializing Interstitial Ad: $err");
//     }
//   }
//
//   @override
//   void onClose() {
//     // Dispose of the banner and interstitial ads when the controller is closed
//     bannerAd.dispose();
//     interstitialAd?.dispose();
//     super.onClose();
//   }
// }


import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobController extends GetxController{
  BannerAd? _bannerAd;
  RxBool isBannerAdReady = false.obs;

  void loadBannerAd(String adUnitId) {
    // Dispose the existing banner ad if any
    _bannerAd?.dispose();

    // Initialize the new banner ad
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isBannerAdReady.value = true;
          print('==================Banner Ad loaded: $adUnitId===================');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('======================Banner Ad failed to load:==================== $error');
          ad.dispose();
          isBannerAdReady.value = false;
        },
      ),
    );

    // Load the banner ad
    _bannerAd?.load();
  }

  BannerAd? get bannerAd => _bannerAd;

  @override
  void onClose() {
    // Dispose of the banner ad when the controller is closed
    _bannerAd?.dispose();
    super.onClose();
  }
}