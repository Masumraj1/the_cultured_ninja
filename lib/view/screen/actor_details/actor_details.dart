import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_following/custom_following.dart';

class ActorDetails extends StatelessWidget {
  ActorDetails({super.key});

  final CustomWidgets customWidget = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///===========================Actor details appbar=============================
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
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///===========================container==================
              // customWidget.customFollowing(
              //   image: AppConstants.onlineImage,
              //   movieName: "Masum Raj", onTap: () {  },
              // ),
              CustomFollowing(
                image: AppConstants.onlineImage,
                movieName: 'Masum Raj',
              ),

              ///===================================Upcoming movies====================
              customWidget.customRow(
                  startTitle: AppStrings.upcomingMovie,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    Get.toNamed(AppRoute.actorMovie);
                  }),
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
                      onTap: (){
                        showDialogBox(context);
                      },
                      image: AppConstants.movieImage,
                      movieName: "The Talented People",
                      releaseDate: '10 august 2023',
                      button: AppStrings.addToCalender,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 24.h,
              ),

              ///=========================His work=========================
              customWidget.customRow(
                  startTitle: AppStrings.hisWork,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    Get.toNamed(AppRoute.actorMovie);
                  }),
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

              ///======================================Actor and director=================
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
                        onTap: () {
                          Get.toNamed(AppRoute.actorDetails);
                        },
                        child: customWidget.customActorAndDirector(
                            image: AppConstants.onlineImage,
                            title: 'actor',
                            designation: 'director'),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        content: SizedBox(
          height: 250.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const CustomImage(
                        imageSrc: AppIcons.x,
                        imageType: ImageType.svg,
                      ))
                ],
              ),

              ///==========================added ===============
              CustomText(
                maxLines: 3,
                fontSize: 18.sp,
                text: AppStrings.addedCalendarSuccessFully,
                fontWeight: FontWeight.w500,
                color: AppColors.lightWhite,
                bottom: 10,
              ),   CustomText(
                maxLines: 3,
                fontSize: 14.sp,
                text: AppStrings.thankYou,
                fontWeight: FontWeight.w400,
                color: AppColors.lightWhite,
                bottom: 10,
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomButton(onTap: (){
                Get.back();
              },
                fillColor: AppColors.buttonColor,
                title: 'Ok',
              )
            ],
          ),
        ),
      ),
    );
  }
}
