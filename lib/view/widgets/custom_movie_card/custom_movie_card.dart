import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/core/app_routes.dart';

class CustomMovieCard extends StatelessWidget {
  final String image;
  final String ratingBar;

  const CustomMovieCard({
    super.key,
    required this.image,
    required this.ratingBar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13, top: 10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.movieDetails);
            },
            child: CustomNetworkImage(
              borderRadius: BorderRadius.circular(13),
              height: 106.h,
              width: 142.w,
              imageUrl: image,
            ),
          ),
          Positioned(
            right: 15,
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                CustomText(
                  left: 5,
                  text: ratingBar,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColors.lightWhite,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
