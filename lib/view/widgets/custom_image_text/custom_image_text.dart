import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';

class CustomImageText extends StatelessWidget {
  final String image;
  final String movieName;

  const CustomImageText({
    super.key,
    required this.image,
    required this.movieName,
  });

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            width: 142.w,
            child: CustomText(
              textAlign: TextAlign.start,
              maxLines: 3,
              text: movieName,
              fontSize: 12.sp,
              color: AppColors.lightWhite,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
