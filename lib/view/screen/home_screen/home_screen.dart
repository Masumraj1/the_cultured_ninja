import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_movie/controller/admob_controller/admob_controller.dart';
import 'package:final_movie/controller/authentication_controller/authentication_controller.dart';
import 'package:final_movie/controller/favorite_controller/favorite_controller.dart';
import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/controller/payment_controller/payment_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/homeScreen_top_rating_movies/home_screen_top_rating_movies.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/home_screen_tv_series/home_screen_tv_series.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/top_rating_tabbar/top_rating_movies_tabbar.dart';
import 'package:final_movie/view/widgets/custom_image_text/custom_image_text.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'inner_widgets/home_appbar/home_appbar.dart';
import 'inner_widgets/side_drawer/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller instances
  final CustomWidgets customWidget = CustomWidgets();
  final HomeController homeController = Get.find<HomeController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final AdmobController admobController = Get.find<AdmobController>();
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();

  // Separate banner ads for main content and bottom navigation
  late final BannerAd _bottomBannerAd;

  @override
  void initState() {
    super.initState();



    // Load bottom banner ad for navigation bar
    _bottomBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() {}),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Failed to load bottom ad: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bottomBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: scaffoldKey,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Conditionally display AdWidget based on payment status
          // Obx(() {
          //   return authenticationController.isSubscription.value
          //       ? const SizedBox.shrink()
          //       : Container(
          //     alignment: Alignment.center,
          //     width: _bottomBannerAd.size.width.toDouble(),
          //     height: _bottomBannerAd.size.height.toDouble(),
          //     child: AdWidget(ad: _bottomBannerAd),
          //   );
          // }),
          const NavBar(currentIndex: 0),
        ],
      ),
      drawer:  SideDrawer(),
      body: Obx(() {
        // Handle loading, error, and completed states for the home data
        switch (homeController.rxRequestStatus.value) {
          case Status.loading:
            return const Center(child: CustomLoader());
          case Status.internetError:
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                homeController.customMethod();
                favoriteController.getFavorite(); // Retry fetching movies and banners
              },
            );
          case Status.completed:
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///====================== Home AppBar and Banner =======================
                  HomeAppBar(scaffoldKey: scaffoldKey),
                  SizedBox(height: 10.w),

                  ///=============================== Carousel Banner =======================
                  _buildBannerCarousel(),

                  SizedBox(height: 24.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///======================== Top Rating Movies Section =========================
                        _buildTopRatingMoviesSection(),
                        SizedBox(height: 10.h),

                        ///======================== My Favorites Section =========================
                        _buildMyFavoritesSection(),
                        SizedBox(height: 16.h),

                        ///============================ Studios Section ============================
                        _buildStudiosSection(),



                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }

  /// Widget: Carousel Banner Section
  Widget _buildBannerCarousel() {
    return Column(
      children: [
        if (homeController.bannerList.isEmpty)
          const Center(child: CustomLoader()) // Loading indicator
        else
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.ease,
              onPageChanged: (int index, reason) {
                homeController.bannerIndex.value = index;
                homeController.pageController.value =
                    PageController(initialPage: homeController.bannerIndex.value);
              },
            ),
            items: homeController.bannerList.map((banner) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(banner.poster ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        SizedBox(height: 16.h),
        SmoothPageIndicator(
          controller: homeController.pageController.value,
          count: homeController.bannerList.length,
          axisDirection: Axis.horizontal,
          effect: const ExpandingDotsEffect(
            expansionFactor: 2,
            spacing: 8.0,
            dotWidth: 10,
            dotHeight: 6.0,
            paintStyle: PaintingStyle.fill,
            dotColor: AppColors.lightWhite,
            activeDotColor: AppColors.buttonColor,
          ),
        ),
      ],
    );
  }

  /// Widget: Top Rating Movies Section
  Widget _buildTopRatingMoviesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customWidget.customRow(
          startTitle: AppStrings.topRatingMovies,
          endTitle: AppStrings.viewAll,
          onTap: () => Get.toNamed(AppRoute.topRatingMovies),
        ),
        SizedBox(height: 16.h),
        TopRatingMoviesTabBar(homeController: homeController),
        SizedBox(height: 16.h),
        IndexedStack(
          index: homeController.selectedIndex.value,
          children: [
            if (homeController.moviesList.isEmpty)
              const CustomText(
                text: 'No Movie Found',
                color: AppColors.lightWhite,
                fontWeight: FontWeight.w500,
              )
            else
              HomeScreenTopRatingMovies(customWidget: customWidget),
            HomeScreenTvSeries(customWidget: customWidget),
          ],
        ),
      ],
    );
  }

  /// Widget: My Favorites Section
  Widget _buildMyFavoritesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customWidget.customRow(
          startTitle: AppStrings.myFavorite,
          endTitle: AppStrings.viewAll,
          onTap: () => Get.toNamed(AppRoute.favoriteScreen),
        ),
        SizedBox(height: 16.h),
        if (favoriteController.favoriteList.isEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.5,
            child: const Center(
              child: CustomText(
                text: 'No Favorite Data Founded',
                color: AppColors.lightWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                favoriteController.favoriteList.length,
                    (index) {
                  var favoriteList = favoriteController.favoriteList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.movieDetails, arguments: [
                        favoriteList.movieId.toString(),
                        favoriteList.rating
                      ]);
                    },
                    child: CustomImageText(
                      image: favoriteList.poster ?? "",
                      movieName: favoriteList.title ?? "",
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  /// Widget: Studios Section
  Widget _buildStudiosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customWidget.customRow(
          startTitle: AppStrings.studios,
          endTitle: AppStrings.viewAll,
          onTap: () => Get.toNamed(AppRoute.studiosScreen),
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              homeController.studioDataList.length,
                  (index) {
                var studioData = homeController.studioDataList[index];
                return CustomImageText(
                  image: "${ApiUrl.networkImageUrl}${studioData.logo ?? ""}",
                  movieName: studioData.name ?? "",
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
