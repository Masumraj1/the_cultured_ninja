import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/screen/favorite_screen/favorite_controller/favorite_controller.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings/app_strings.dart';
import '../../widgets/custom_text/custom_text.dart';

class FavoriteScreen extends StatelessWidget {
   FavoriteScreen({super.key});


  ///=================================favorite controller =================
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  final CustomWidgets customWidget = CustomWidgets();
  @override
  Widget build(BuildContext context) {



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
                child: customWidget.customFavorite(
                  image: AppConstants.lover,
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