import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/following_screen/following_controller/following_controller.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FollowingTabBar extends StatelessWidget {
  const FollowingTabBar({
    super.key,
    required this.followingController,
  });

  final FollowingController followingController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ///==========================Actor Button==================================
          GestureDetector(
            onTap: (){
              followingController.changeTab(0);
            },
            child: CustomText(
                text: AppStrings.actor,
                color: followingController.selectedIndex.value == 0
                    ? AppColors.tavChangeColor
                    : AppColors.lightWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                decoration: followingController.selectedIndex.value == 0
                    ? TextDecoration.underline
                    : TextDecoration.none),
          ),
          const Spacer(),

          ///=================================Studios button====================
          GestureDetector(
            onTap: () {
              followingController.changeTab(1);
            },
            child: CustomText(
              text: AppStrings.studios,
              color: followingController.selectedIndex.value == 1
                  ? AppColors.tavChangeColor
                  : AppColors.lightWhite,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              decoration: followingController.selectedIndex.value == 1
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
        ],
      );
    });
  }
}
