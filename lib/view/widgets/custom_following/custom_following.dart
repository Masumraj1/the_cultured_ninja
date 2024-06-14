import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFollowing extends StatefulWidget {
  const CustomFollowing({
    super.key,
    this.isTap = true,
    required this.image,
    required this.movieName,
  });

  final bool isTap;
  final String image;
  final String movieName;

  @override
  State<CustomFollowing> createState() => _CustomFollowingState();
}

class _CustomFollowingState extends State<CustomFollowing> {
  bool isFollowing = true;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.isTap;
  }

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.fromRgb,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.borderRgb),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            boxShape: BoxShape.circle,
            imageUrl: widget.image,
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
                  text: widget.movieName,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  bottom: 7,
                ),
                GestureDetector(
                  onTap: toggleFollow,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 40.h,
                    width: 114.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:  AppColors.blackDeep,
                    ),
                    child: Row(
                      children: [
                        CustomImage(
                          imageSrc: isFollowing
                              ? AppIcons.profileSelected
                              : AppIcons.unFollow,
                        ),
                        CustomText(
                          left: 10,
                          text: isFollowing ? AppStrings.following : AppStrings.unfollow,
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
