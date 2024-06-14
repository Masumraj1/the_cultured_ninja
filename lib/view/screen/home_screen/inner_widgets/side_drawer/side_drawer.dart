import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  Widget customRow(
          {required String image,
          required String title,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColors.borderDrawer),
                bottom: BorderSide(color: AppColors.borderDrawer),
                right: BorderSide(color: AppColors.borderDrawer)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 39),
            child: Row(
              children: [
                CustomImage(
                  size: 18.r,
                  imageSrc: image,
                ),
                CustomText(
                  color: AppColors.lightWhite,
                  left: 16.w,
                  text: title,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.w,
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 64),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
        color: AppColors.backgroundColor,
      ),
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        children: [
          ///================================ APP LOGO ==============================///
          const CustomText(text: "LogoHere",color: AppColors.lightWhite,),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30.h,  right: 20.w),
                child: Column(
                  children: [
                    ///=======================Profile =====================


                    customRow(
                        image: AppIcons.user,
                        title: AppStrings.profile,
                        onTap: () {
                          Get.toNamed(AppRoute.profileScreen);
                        }),

                    ///==============================Settings =====================
                    customRow(
                        image: AppIcons.settings,
                        title: AppStrings.settings,
                        onTap: () {
                          Get.toNamed(AppRoute.settingScreen);
                        }),



                    ///==============================Sign Out======================

                    SizedBox(
                      height: 350.h,
                    ),
                    customRow(
                        image: AppIcons.logOut,
                        title: AppStrings.logOut,
                        onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
