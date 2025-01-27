import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';

class CustomSearchCard extends StatelessWidget {
  final String image;
  final String movieName;
  final String releaseDate;

  const CustomSearchCard({
    super.key,
    required this.image,
    required this.movieName,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.fromRgb,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.borderDrawer),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: image,
            height: 97,
            width: 142,
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
                  maxLines: 3,
                  text: movieName,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  bottom: 7,
                ),
             Row(
               children: [
                const Icon(Icons.star,color: Colors.amberAccent,),
                 CustomText(
                   left: 10,
                   text: releaseDate,
                   color: AppColors.favoriteContainerTextColor,
                   fontWeight: FontWeight.w400,
                   fontSize: 14,
                 ),
               ],
             )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
