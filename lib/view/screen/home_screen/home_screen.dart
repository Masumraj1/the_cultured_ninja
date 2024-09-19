
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/home_screen_tv_series/home_screen_tv_series.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/top_rating_tabbar/top_rating_movies_tabbar.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'inner_widgets/homeScreen_top_rating_movies/home_screen_top_rating_movies.dart';
import 'inner_widgets/home_appbar/home_appbar.dart';
import 'inner_widgets/side_drawer/side_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final CustomWidgets customWidget = CustomWidgets();

  final HomeController homeController = Get.find<HomeController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: scaffoldKey,
      bottomNavigationBar: const NavBar(currentIndex: 0),

      ///===================================Side Drawer=============================
      drawer: const SideDrawer(),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ///====================== Home AppBar and banner =======================
              HomeAppBar(scaffoldKey: scaffoldKey),
              SizedBox(
                height: 10.w,
              ),

              ///===============================This is banner=======================
              Column(

                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.ease,
                      pageSnapping: false,
                      onPageChanged: (int index, reason) {
                        homeController.bannerIndex.value = index;
                        homeController.pageController.value = PageController(
                            initialPage: homeController.bannerIndex.value);
                      },
                    ),
                    items: homeController.bannerImg.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imagePath))),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SmoothPageIndicator(
                    controller: homeController.pageController.value,
                    count: homeController.bannerImg.length,
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
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///======================Top Rating Movies==================
                customWidget.customRow(
                    startTitle: AppStrings.topRatingMovies,
                    endTitle: AppStrings.viewAll,
                    onTap: (){
                      Get.toNamed(AppRoute.topRatingMovies);
                    }),

                        ///==============================Movies and tv series==============
                                    SizedBox(
                                      height: 16.h,
                                    ),
                        TopRatingMoviesTabBar(homeController: homeController,),
                        SizedBox(
                          height: 16.h,
                        ),
                        IndexedStack(
                          index: homeController.selectedIndex.value,
                          children: [
                            HomeScreenTopRatingMovies(customWidget: customWidget),
                             HomeScreenTvSeries(customWidget: customWidget)
                          ],
                        ),

                        ///===================================My favorite========================
                        customWidget.customRow(
                            startTitle: AppStrings.myFavorite,
                            endTitle: AppStrings.viewAll,
                            onTap: (){
                              Get.toNamed(AppRoute.favoriteScreen);
                            }),
                        SizedBox(
                          height: 16.h,
                        ),
                        SizedBox(
                          height: 170.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.tvSeriesList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.movieDetails);
                                  },
                                  child: customWidget.customImageText(
                                      image: homeController.tvSeriesList[index],
                                      movieName: "Bad Boy"),
                                );
                              }),
                        ),

                        ///============================Studios============================
                        customWidget.customRow(
                            startTitle: AppStrings.studios,
                            endTitle: AppStrings.viewAll,
                            onTap: (){
                              Get.toNamed(AppRoute.studiosScreen);
                            }),
                        SizedBox(
                          height: 16.h,
                        ),

                        SizedBox(
                          height: 170.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.studiosList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.studiosDetailsScreen);
                                  },
                                  child: customWidget.customImageText(
                                      image: homeController.studiosList[index],
                                      movieName: "Bad Boy"),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}


