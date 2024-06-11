import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  ///================================Custom Profile===================
  Widget customProfile({
    required String title,
    required String subTitle
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            color: AppColors.lightWhite,
            text: title,
            fontWeight: FontWeight.w400,
            fontSize: 16.w,
            bottom: 8,
          ),
          CustomText(
            color: AppColors.lightWhite,
            text: subTitle,
            fontWeight: FontWeight.w400,
            fontSize: 16.w,
            bottom: 20,
          ),

        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const NavBar(currentIndex: 4),
      ///===============================Profile Appbar=====================
      appBar: AppBar(
        actions:  [

          InkWell(
              onTap: (){
                Get.toNamed(AppRoute.editProfileScreen);
              },
              child: const CustomImage(imageSrc: AppIcons.edit,imageType: ImageType.svg,)),
          const SizedBox(width: 10,),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
          text: AppStrings.profile,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              ///<<<<========================================Profile Image======================================
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                // Same radius as the container
                child: CustomImage(
                  imageSrc: AppImages.man,
                  imageType: ImageType.png,
                  size: 100.sp,
                ),
              ),

              ///<<<<========================================Name======================================
              CustomText(
                text: AppStrings.cameronWilliamson,
                color: AppColors.lightWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                bottom: 7,
                top: 12,
              ),

              ///<<<<========================================Email======================================
              CustomText(
                text: AppStrings.mariaEmail,
                color: AppColors.lightWhite,
                fontSize: 14.sp,
                bottom: 27,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.fromRgb,
                  border: Border.all(
                    color: AppColors.borderDrawer, // Specify the border color
                    width: 2.0, // Specify the border width
                    style: BorderStyle.solid, // Specify the border style
                  ),
                  borderRadius: BorderRadius.circular(8.r), // Added border radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: AppStrings.personalInformation,
                      color: AppColors.textNormalPerPal,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      bottom: 16,
                    ),

                    ///============================Name========================
                    customProfile(
                        title: AppStrings.name,
                        subTitle: AppStrings.cameronWilliamson),
                    ///============================phone Number================
                    customProfile(
                        title: AppStrings.phoneNumber,
                        subTitle: "+1 145528 455265"),
                  ///================================Email=====================
                    customProfile(
                        title: AppStrings.email,
                        subTitle: AppStrings.mariaEmail),
                 ///===============================Address======================
                    customProfile(
                        title: AppStrings.address,
                        subTitle: "Bushwick Brooklyn, NY, USA"),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
