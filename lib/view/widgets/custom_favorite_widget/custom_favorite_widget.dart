import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart'; // Your custom color file
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart'; // Your custom network image widget
import 'package:final_movie/view/widgets/custom_text/custom_text.dart'; // Your custom text widget

class CustomFavoriteWidget extends StatelessWidget {
  final String image;
  final String movieName;
  final String releaseDate;
  final String date;
  final bool? isExpanded;
  final bool? isDate;
  final VoidCallback onTap;

  const CustomFavoriteWidget({
    super.key,
    required this.image,
    required this.movieName,
    required this.releaseDate,
    required this.isExpanded,
    required this.onTap, this.isDate, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.fromRgb,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.borderDrawer),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  bottom: 8,
                  maxLines: 5,
                  text: movieName,
                  fontSize: 15.sp,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w400,
                ),
               isDate==true?
               Column(
                 children: [
                   CustomText(
                     maxLines: 2,
                     text: 'Release Date', // Use static text or AppStrings.releaseDate
                     fontSize: 12.sp,
                     color: AppColors.favoriteContainerTextColor,
                     fontWeight: FontWeight.w400,
                   ),
                   CustomText(
                     top: 10,
                     text: releaseDate,
                     fontSize: 12.sp,
                     color: AppColors.favoriteContainerTextColor,
                     fontWeight: FontWeight.w400,
                   ),
                 ],
               ): CustomText(
                 maxLines: 2,
                 text: 'Remember Date', // Use static text or AppStrings.releaseDate
                 fontSize: 12.sp,
                 color: AppColors.favoriteContainerTextColor,
                 fontWeight: FontWeight.w400,
               ),
                CustomText(
                  top: 10,
                  text: date,
                  fontSize: 12.sp,
                  color: AppColors.yesButtonColor,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          if (isExpanded ?? false) // Handle null case properly
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.buttonColor),
              onPressed: onTap
            ),
        ],
      ),
    );
  }
}
