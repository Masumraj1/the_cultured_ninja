import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/screen/favorite_screen/favorite_controller/favorite_controller.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings/app_strings.dart';
import '../../widgets/custom_text/custom_text.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {


    ///=================================favorite controller =================
    final FavoriteController favoriteController = Get.find<FavoriteController>();


    ///====================================Custom favorite ====================
    Widget customFavorite({
      required String image,
      required String movieName,
      required String releaseDate,
      required bool isExpanded,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.fromRgb,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.borderDrawer)),
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
              ),
              if (isExpanded)
                IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.buttonColor),
                  onPressed: () {
                    // Handle delete action
                  },
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3),
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
            text: AppStrings.favourite,
            fontSize: 20.sp,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 13),
        child: Obx(() {
          return ListView.builder(
            itemCount: favoriteController.isExpandedList.length, // Update with your actual item count
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: customFavorite(
                  image: AppConstants.movieImage,
                  movieName: 'Star Wars: The Rise of Skywalker (2024)',
                  releaseDate: '15 May 2020',
                  isExpanded: favoriteController.isExpandedList[index],
                  onTap: () => favoriteController.toggleExpand(index),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}