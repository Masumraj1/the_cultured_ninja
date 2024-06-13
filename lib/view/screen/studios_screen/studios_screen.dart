import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudiosScreen extends StatelessWidget {
  const StudiosScreen({super.key});


  ///============================customStudios========================
  Widget customWidgets({
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
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: CustomText(
            text: AppStrings.studios,
            fontSize: 20.sp,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            left: 21,
            top: 24,
            text: AppStrings.allStudio,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            bottom: 24,
          ),
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.toNamed(AppRoute.studiosDetailsScreen);
            },
            child: customWidgets(
                image: AppConstants.disneyPlus,
                movieName: "Disney Plus"),
          );
        },
      )
        ],
      ),
    );
  }
}
