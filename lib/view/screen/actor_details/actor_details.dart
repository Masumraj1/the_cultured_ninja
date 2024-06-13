import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActorDetails extends StatelessWidget {
  ActorDetails({super.key});

  final CustomWidgets customWidget = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
          text: AppStrings.actorDetails,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customWidget.customFollowing(
                image: AppConstants.onlineImage,
                movieName: "Masum Raj",
              ),
              SizedBox(
                height: 24.h,
              ),
              ///===================================Upcoming movies====================
              Row(
                children: [
                  CustomText(
                    text: AppStrings.upcomingMovie,
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
                height: 350.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return customWidget.customUpcomingMovies(
                      image: AppConstants.movieImage,
                      movieName: "The Talented People",
                      releaseDate: '10 august 2023', button: AppStrings.addToCalender,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 24.h,
              ),

              ///=========================His work=========================
              Row(
                children: [
                  CustomText(
                    text: AppStrings.hisWork,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightWhite,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoute.actorMovie);
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
                      movieName: "The Talented People",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
