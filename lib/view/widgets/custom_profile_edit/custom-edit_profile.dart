import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';

class CustomEditProfile extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const CustomEditProfile({
    super.key,
    required this.title,
    required this.controller,
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
          bottom: 13,
        ),
        CustomTextField(
          textEditingController: controller,
          inputTextStyle: const TextStyle(color: AppColors.lightWhite),
          fillColor: AppColors.fromRgb,
          fieldBorderColor: AppColors.borderDrawer,
          keyboardType: TextInputType.name,
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}
