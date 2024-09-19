import 'package:final_movie/controller/filter_controller/filter_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterSelectedGenresScreen extends StatelessWidget {
  const FilterSelectedGenresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FilterController filterController = Get.find<FilterController>();
    final List<String> genres = [
      "Action",
      "Adventure",
      "Comedy",
      "Drama",
      "Horror",
      "Musicals",
      "Mystery"
    ];

    return Scaffold(
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
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
          color: AppColors.lightWhite,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///============================Genres=====================
              CustomText(
                text: AppStrings.genres,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
                color: AppColors.lightWhite,
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: genres.map((genre) {
                  return GestureDetector(
                    onTap: () => filterController.toggleGenreSelection(genre),
                    child: Obx(() {
                      final bool isSelected =
                          filterController.selectedGenres.contains(genre);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13.0, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.buttonColor
                              : AppColors.genreUnselectedColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: genre,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColors.lightWhite,
                            ),
                            if (isSelected) const SizedBox(width: 5.0),
                            if (isSelected)
                              Icon(
                                Icons.close,
                                color: AppColors.lightWhite,
                                size: 16.sp,
                              ),
                          ],
                        ),
                      );
                    }),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 320.h,
              ),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoute.filterScreen
                  );
                },
                fillColor: AppColors.buttonColor,
                title: AppStrings.search,
                textColor: AppColors.lightWhite,
              )
            ],
          ),
        ),
      ),
    );
  }
}
