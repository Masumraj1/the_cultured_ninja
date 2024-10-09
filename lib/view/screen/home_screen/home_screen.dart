import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_movie/controller/favorite_controller/favorite_controller.dart';
import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/homeScreen_top_rating_movies/home_screen_top_rating_movies.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/home_screen_tv_series/home_screen_tv_series.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/top_rating_tabbar/top_rating_movies_tabbar.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'inner_widgets/home_appbar/home_appbar.dart';
import 'inner_widgets/side_drawer/side_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CustomWidgets customWidget = CustomWidgets();
  final HomeController homeController = Get.find<HomeController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: scaffoldKey,
      bottomNavigationBar: const NavBar(currentIndex: 0),
      drawer: const SideDrawer(),
      body: Obx(() {
        switch (homeController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                homeController
                    .customMethod();
                favoriteController
                    .getFavorite(); // Retry fetching movies and banners
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

                  ///=============================== This is Banner =======================
                  Column(
                    children: [
                      if (homeController.bannerList.isEmpty)
                        const Center(child: CustomLoader()) // Loading indicator
                      else
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayCurve: Curves.ease,
                            onPageChanged: (int index, reason) {
                              homeController.currentBannerIndex.value = index;
                            },
                          ),
                          items: homeController.bannerList.map((banner) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
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
                      // SmoothPageIndicator
                      SmoothPageIndicator(
                        controller: homeController.pageController.value,
                        count: homeController.bannerList.length,
                        axisDirection: Axis.horizontal,
                        effect: const ExpandingDotsEffect(
                          expansionFactor: 3,
                          spacing: 8.0,
                          dotWidth: 10,
                          dotHeight: 6.0,
                          paintStyle: PaintingStyle.fill,
                          dotColor: AppColors.lightWhite,
                          activeDotColor: AppColors.buttonColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ///======================== Top Rating Movies =========================

                        customWidget.customRow(
                          startTitle: AppStrings.topRatingMovies,
                          endTitle: AppStrings.viewAll,
                          onTap: () {
                            Get.toNamed(AppRoute.topRatingMovies);
                          },
                        ),

                        SizedBox(height: 16.h),

                        ///================ Top Rating Movies Tab Bar======
                        TopRatingMoviesTabBar(homeController: homeController),
                        SizedBox(height: 16.h),
                        IndexedStack(
                          index: homeController.selectedIndex.value,
                          children: [

                            ///========================Movies================
                            homeController.moviesList.isEmpty
                                ? const CustomText(
                              text: 'No Movie Found',
                              color: AppColors.lightWhite,
                              fontWeight: FontWeight.w500,
                            )
                                : HomeScreenTopRatingMovies(
                              customWidget: customWidget,
                            ),

                            ///========================Tv Series================
                            HomeScreenTvSeries(customWidget: customWidget)
                          ],
                        ),

                        SizedBox(
                          height: 10.h,
                        ),

                        ///======================== My Favorites =========================
                        customWidget.customRow(
                          startTitle: AppStrings.myFavorite,
                          endTitle: AppStrings.viewAll,
                          onTap: () {
                            Get.toNamed(AppRoute.favoriteScreen);
                          },
                        ),

                        SizedBox(height: 16.h),


                        if (favoriteController.favoriteList.isEmpty) SizedBox(
                          height: MediaQuery.of(context).size.height/3.5,
                          child: const Center(
                            child: CustomText(
                              text: 'No Favorite Data Founded',
                              color: AppColors.lightWhite,
                              fontWeight: FontWeight.w500,),
                          ),
                        ) else Row(
                          children: List.generate(favoriteController
                              .favoriteList.length, (index) {
                            var favoriteList = favoriteController
                                .favoriteList[index];
                            return GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoute.movieDetails,
                                    arguments: [
                                      favoriteList.movieId.toString(),
                                     favoriteList.rating
                                    ]);
                              },
                              child: customWidget.customImageText(
                                image: favoriteList.poster ?? "",
                                movieName: favoriteList.title ?? "",
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 16.h),

                        ///============================ Studios ============================
                        customWidget.customRow(
                          startTitle: AppStrings.studios,
                          endTitle: AppStrings.viewAll,
                          onTap: () {
                            Get.toNamed(AppRoute.studiosScreen);
                          },
                        ),

                        SizedBox(height: 16.h),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                homeController.studioDataList.length, (index) {
                              var studioData = homeController
                                  .studioDataList[index];
                              return customWidget.customImageText(
                                image: "${ApiUrl.networkImageUrl}${studioData
                                    .logo ?? ""}",
                                movieName: studioData.name ?? "",
                              );
                            }),
                          ),
                        )
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
}
