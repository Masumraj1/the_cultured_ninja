import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

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
        backgroundColor: AppColors.backgroundColor,
        title: CustomText(
          text: AppStrings.movieDetails,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),

      ///====================================body=============================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            CustomNetworkImage(
                borderRadius: BorderRadius.circular(14),
                imageUrl: AppConstants.movieImage,
                height: 241.h,
                width: double.infinity),
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
            child: Row(
              children: [
                CustomText(
                  textAlign: TextAlign.center,
                  text: AppStrings.addToFavorite,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                const Icon(Icons.favorite,color: AppColors.lightWhite,)
              ],
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
            ),
          ],
        ),
      ),
    );
  }
}
