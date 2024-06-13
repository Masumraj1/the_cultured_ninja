// Removed the problematic import
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWidgets {
  ///============================Custom Flowing=====================
  Widget customFollowing({
    required String image,
    required String movieName,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.fromRgb,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderRgb)),
      child: Row(
        children: [
          CustomNetworkImage(
            boxShape: BoxShape.circle,
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
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40.h,
                  width: 114.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.blackDeep),
                  child: Row(
                    children: [
                      const CustomImage(imageSrc: AppIcons.profileSelected),
                      CustomText(
                        left: 10,
                        text: AppStrings.following,
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///=============================================customUpcomingMovies===================
  Widget customUpcomingMovies({
    required String image,
    required String movieName,
    required String releaseDate,
    required String button,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            borderRadius: BorderRadius.circular(13),
            height: 226.h,
            width: 160.w,
            imageUrl: image,
          ),
          CustomText(
            top: 12,
            textAlign: TextAlign.start,
            maxLines: 5,
            text: movieName,
            fontSize: 18.sp,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            textAlign: TextAlign.start,
            maxLines: 2,
            text: releaseDate,
            fontSize: 12.sp,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomButton(
            height: 50,
            width: 160.w,
            onTap: (){},title: button,fillColor: AppColors.buttonColor,),


        ],
      ),
    );
  }


  ///===============================================CustomImageText====================
  Widget customImageText({
    required String image,
    required String movieName,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            borderRadius: BorderRadius.circular(13),
            height: 106.h,
            width: 142.w,
            imageUrl: image,
          ),
          SizedBox(
            height: 12.h,
          ),
          CustomText(
              textAlign: TextAlign.start,
              maxLines: 5,
              text: movieName,
              fontSize: 12.sp,
              color: AppColors.lightWhite,
              fontWeight: FontWeight.w400),
        ],
      ),
    );
  }

  ///====================================Custom Movie=============================
  Widget customMovie({
    required String image,
    required String movieName,
    required String releaseDate,
    required String year,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.fromRgb,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderDrawer)),
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

                CustomText(
                  text: year,
                  color: AppColors.favoriteContainerTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ), CustomText(
                  text: releaseDate,
                  color: AppColors.favoriteContainerTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  ///=================================custom Actor movies=======================

  Widget customActorMovie({
    required String image,
    required String movieName,
    required String releaseDate,
    required String button,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.fromRgb,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderDrawer)),
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
                   CustomText(
                  text: releaseDate,
                  color: AppColors.favoriteContainerTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                     bottom: 10,
                ),
                CustomButton(onTap: (){},
                title: button,
                  width: 134.w,
                  height: 37.h,
                  fillColor: AppColors.buttonColor,
                )

              ],
            ),
          )
        ],
      ),
    );
  }


  ///============================custom Actor and director========================
  Widget customActorAndDirector({
    required String image,
    required String title,
    required String designation,
  }) {
    return SizedBox(
      height: 124.h,
      width: 90.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Column(
          children: [
            CustomNetworkImage(
              boxShape: BoxShape.circle,
              height: 56.h,
              width: 56.w,
              imageUrl: image,
            ),
            CustomText(
                text: title,
                top: 8,
                fontSize: 12.sp,
                color: AppColors.lightWhite,
                fontWeight: FontWeight.w400),
            CustomText(
                maxLines: 5,
                text: designation,
                fontSize: 14.sp,
                color: AppColors.lightWhite,
                fontWeight: FontWeight.w400),
          ],
        ),
      ),
    );
  }
}
