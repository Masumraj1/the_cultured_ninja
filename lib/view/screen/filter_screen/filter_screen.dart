import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings/app_strings.dart';
import '../../widgets/custom_text/custom_text.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  ///====================================Custom favorite ====================
  Widget customFilter({
    required String image,
    required String movieName,
    required String releaseDate,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.fromRgb,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderDrawer)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            height: 97,
            width: 142,
            imageUrl: image,
          ),
          SizedBox(
            width: 14.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  textAlign: TextAlign.start,
                  bottom: 8,
                  maxLines: 5,
                  text: movieName,
                  fontSize: 15.sp,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w400),
              CustomText(
                  maxLines: 2,
                  text: AppStrings.releaseDate,
                  fontSize: 12.sp,
                  color: AppColors.favoriteContainerTextColor,
                  fontWeight: FontWeight.w400),
              CustomText(
                  text: releaseDate,
                  fontSize: 12.sp,
                  color: AppColors.favoriteContainerTextColor,
                  fontWeight: FontWeight.w400),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      ///==================================Favorite Appbar ==========================
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
            text: AppStrings.filter,
            fontSize: 20.sp,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context,index) {
        return customFilter(
            image: AppConstants.movieImage,
            movieName: 'bad boy',
            releaseDate: "10 august 2023");
      })
    );
  }
}
