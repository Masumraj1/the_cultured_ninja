import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'inner_widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: scaffoldKey,

      ///===================================Side Drawer=============================
      // drawer: SideDrawer(),
      // bottomNavigationBar: const NavBar(currentIndex: 0),
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
                            CustomText(
                              text: AppStrings.viewAll,
                              color: AppColors.lightWhite,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: AppStrings.myFavorite,
                              color: AppColors.lightWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            CustomText(
                              text: AppStrings.viewAll,
                              color: AppColors.lightWhite,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: AppStrings.studios,
                              color: AppColors.lightWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            CustomText(
                              text: AppStrings.viewAll,
                              color: AppColors.lightWhite,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
