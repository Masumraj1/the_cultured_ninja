import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key});

  ///============================customStudios========================
  final CustomWidgets customWidget = CustomWidgets();




  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///==========================AppBar==========================
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
          text: AppStrings.movieDetails,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),

      ///====================================body=============================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  borderRadius: BorderRadius.circular(14),
                  imageUrl: AppConstants.movieImage,
                  height: 241.h,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 14.h,
                ),

                ///=========================Follow button======================
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.buttonColor,
                  ),
                  height: 50.h,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: homeController.toggleFavorite,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: AppStrings.addToFavorite,
                            color: AppColors.lightWhite,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            right: 10,
                          ),
                          Icon(
                            homeController.isFavorite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColors.lightWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomText(
                  top: 26,
                  textAlign: TextAlign.start,
                  text: AppStrings.warnerBros,
                  fontSize: 18.sp,
                  maxLines: 6,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightWhite,
                  bottom: 12,
                ),
                ///==================================synopsis===========================
                CustomText(
                  top: 16,
                  text: AppStrings.synopsis,
                  fontSize: 16.sp,
                  bottom: 8,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightWhite,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  text: AppStrings.weAreDedicated,
                  fontSize: 12.sp,
                  maxLines: 5,
                  bottom: 24,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightWhite,
                ),

                ///==================================Cost & Crew====================
                CustomText(
                  text: AppStrings.actorsAndDirector,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightWhite,
                  bottom: 16,
                ),
                SizedBox(
                  height: 140.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.actorDetails);
                          },
                          child: customWidget.customActorAndDirector(
                              image: AppConstants.onlineImage,
                              title: 'actor',
                              designation: 'director'),
                        );
                      }),
                ),

                ///==================================related Movies====================

                Row(
                  children: [
                    CustomText(
                      text: AppStrings.relatedMovies,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoute.allMovies);
                      },
                      child: CustomText(
                        text: AppStrings.viewAll,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightWhite,
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
                        return customWidget.customImageText(
                            image: AppConstants.movieImage,
                            movieName: "Universal Studios");
                      }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
