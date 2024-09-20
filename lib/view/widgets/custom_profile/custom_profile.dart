import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';

class CustomProfile extends StatelessWidget {
  final String title;
  final String subTitle;

  const CustomProfile({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
  }
}
