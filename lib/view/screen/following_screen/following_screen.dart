import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  ///===========================customFavorite===============================
  Widget customFavorite({
    required String image,
    required String movieName,
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
                    color: AppColors.blackDeep
                  ),
                  child: Row(
                    children: [
                      const CustomImage(imageSrc: AppIcons.profileSelected),
                      CustomText(left:10,text: AppStrings.following,color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.w400,),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const NavBar(currentIndex: 1),
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
          text: AppStrings.favourite,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 13),
          child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context,index){
                return   customFavorite(
                    image: AppConstants.onlineImage,
                    movieName: 'Leonardo DiCaprio ,Actor',);
              })
      ),
    );
  }
}
