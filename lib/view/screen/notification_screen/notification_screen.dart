import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Widget customFollowing(
      {required String image,
      required String movieName,
      required String title,
      required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 3,
          text: title,
          color: AppColors.lightWhite,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          bottom: 7,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl: image,
              height: 97,
              width: 142,
            ),
            CustomText(
              left: 20,
              textAlign: TextAlign.start,
              maxLines: 3,
              text: movieName,
              color: AppColors.lightWhite,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              bottom: 7,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///===============================Notification Appbar=====================
      appBar: AppBar(
        backgroundColor: AppColors.blackDeep,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        title: CustomText(
          text: AppStrings.notifications,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            customFollowing(
                image: AppConstants.movieImage,
                movieName: "Avengers: Endgame",
                onTap: () {},
                title: 'New Reals movie 2024 '),
            SizedBox(
              height: 20.h,
            ),
            customFollowing(
                image: AppConstants.movieImage,
                movieName: "Avengers: Endgame",
                onTap: () {},
                title: 'Reminder'),
            SizedBox(
              height: 20.h,
            ),
            customFollowing(
                image: AppConstants.movieImage,
                movieName: "Avengers: Endgame",
                onTap: () {},
                title: 'Reviews & Ratings'),
          ],
        ),
      ),
    );
  }
}
