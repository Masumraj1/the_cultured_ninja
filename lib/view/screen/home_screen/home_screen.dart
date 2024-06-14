
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/top_rating_tabbar/top_rating_movies_tabbar.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
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
                        Row(
                          children: [
                            CustomText(
                              text: AppStrings.topRatingMovies,
                              color: AppColors.lightWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoute.topRatingMovies);
                              },
                              child: CustomText(
                                text: AppStrings.viewAll,
                                color: AppColors.lightWhite,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),

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
                            HomeScreenTopRatingMovies(customWidget: customWidget),

                          ],
                        ),

                        ///===================================My favorite========================
                        Row(
                          children: [
                            CustomText(
                              text: AppStrings.myFavorite,
                              color: AppColors.lightWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoute.favoriteScreen);
                              },
                              child: CustomText(
                                text: AppStrings.viewAll,
                                color: AppColors.lightWhite,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        SizedBox(
                          height: 170.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.movieDetails);
                                  },
                                  child: customWidget.customImageText(
                                      image: AppConstants.movieImage,
                                      movieName: "Bad Boy"),
                                );
                              }),
                        ),

                        ///============================Studios============================
                        Row(
                          children: [
                            CustomText(
                              text: AppStrings.studios,
                              color: AppColors.lightWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoute.studiosScreen);
                              },
                              child: CustomText(
                                text: AppStrings.viewAll,
                                color: AppColors.lightWhite,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        SizedBox(
                          height: 170.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.studiosDetailsScreen);
                                  },
                                  child: customWidget.customImageText(
                                      image: AppConstants.disneyPlus,
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


