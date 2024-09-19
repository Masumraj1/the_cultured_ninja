import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TopRatingMoviesTabBar extends StatelessWidget {
  const TopRatingMoviesTabBar({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          ///==========================Actor Button==================================
          GestureDetector(
            onTap: (){
              homeController.changeTab(0);
            },
            child: CustomText(
              textAlign: TextAlign.start,
                text: AppStrings.movies,
                color: homeController.selectedIndex.value == 0
                    ? AppColors.tavChangeColor
                    : AppColors.lightWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                decoration: homeController.selectedIndex.value == 0
                    ? TextDecoration.underline
                    : TextDecoration.none),
          ),


          SizedBox(
            width: 40.w,
          ),

          ///=================================Studios button====================
          GestureDetector(
            onTap: () {
              homeController.changeTab(1);
            },
            child: CustomText(
              text: AppStrings.tvSeries,
              color: homeController.selectedIndex.value == 1
                  ? AppColors.tavChangeColor
                  : AppColors.lightWhite,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              decoration: homeController.selectedIndex.value == 1
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
        ],
      );
    });
  }
}
