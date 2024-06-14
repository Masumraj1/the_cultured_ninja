import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/screen/home_screen/inner_widgets/top_rating_tabbar/top_rating_movies_tabbar.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TopRatingMovies extends StatelessWidget {
   TopRatingMovies({super.key});

  ///===========================custom top rating movies=========================
  Widget customTopRatingMovies({
    required String image,
    required String movieName,
    required String ratings,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.fromRgb,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.borderDrawer),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: image,
            height: 97,
            width: 142,
          ),
          SizedBox(
            width: 14.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  text: movieName,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  bottom: 7,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 5.w),
                    CustomText(
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      text: ratings,
                      color: AppColors.lightWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


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
          child: Column(
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

              Column(
                children: List.generate(4, (index) {
                  return customTopRatingMovies(
                    image: AppConstants.movieImage,
                    movieName: 'Bad Boy',
                    ratings: '4.5',
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
