import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/top_rating_tabbar/top_rating_movies_tabbar.dart';
import 'package:final_movie/view/screen/top_rating_movies/inner/top_rating_tv_series_list.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'inner/top_rating_movies_list.dart';

class TopRatingMovies extends StatelessWidget {
   TopRatingMovies({super.key});

   final CustomWidgets customWidget = CustomWidgets();



    final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///=================================top rating movies appbar=====================
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
          text: AppStrings.topRatingMovies,
          fontSize: 20.sp,
          color: AppColors.lightWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///==========================Search field=============================
                  Row(
                    children: [
                      const Expanded(
                        flex: 8,
                        child: CustomTextField(
                          fillColor: AppColors.fromRgb,
                          fieldBorderColor: AppColors.fromRgb,
                          hintText: AppStrings.search,
                          hintStyle: TextStyle(color: AppColors.searchHintText),
                          isPrefixIcon: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.search,
                              color: AppColors.searchHintText,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14.h,
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.filterSelectedGenresScreen);
                          },
                          child: Container(
                              height: 50,
                              width: 54,
                              decoration: BoxDecoration(
                                color: AppColors.fromRgb,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.filter_alt,
                                size: 35,
                                color: AppColors.lightWhite,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),

                  ///================================Top rating movies=============================
                  CustomText(
                    text: AppStrings.topRatingMovies,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightWhite,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ///====================================Movies and tv series tab bar===============
                  TopRatingMoviesTabBar(homeController: homeController,),
                  SizedBox(
                    height: 16.h,
                  ),
                  IndexedStack(
                    index: homeController.selectedIndex.value,
                    children: [
                      TopRatingMoviesList(customWidget: customWidget),
                      TopRatingTvSeriesList(customWidget: customWidget)
                     ],
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}


