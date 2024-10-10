import 'package:final_movie/controller/streaming_controller/streaming_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterSelectedGenresScreen extends StatelessWidget {
  FilterSelectedGenresScreen({super.key});

  final StreamingController streamingController =
      Get.find<StreamingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///=============================Filter Appbar==================
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
      body: Obx(() {
        switch (streamingController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              streamingController.getAllGenre();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                streamingController.getAllGenre();
              },
            );

          case Status.completed:
            return Padding(
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
                      children: streamingController.genreData.map((genre) {
                        return GestureDetector(
                          onTap: () {
                            // Print the genre id
                            print('Selected Genre ID:======================== ${genre.id.toString()}');

                            streamingController.selectGenre(
                              genre.id.toString(),
                              genre.name ?? "",
                            );
                          },
                          child: Obx(() {
                            final bool isSelected =
                                streamingController.selectedGenre.value ==
                                    genre.name;
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
                                    text: genre.name ?? "",
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

                    ///=============================Search Button=================
                    CustomButton(
                      onTap: () {
                        // Check if a genre is selected and pass the genre.id as argument
                        final selectedGenreId = streamingController.genreData
                            .firstWhere((genre) => genre.name == streamingController.selectedGenre.value)
                            .id
                            .toString();

                        // Navigate to the filter screen and pass the selected genre ID as argument
                        Get.toNamed(AppRoute.filterScreen, arguments: selectedGenreId);


                        debugPrint('===========================$selectedGenreId');
                      },
                      fillColor: AppColors.buttonColor,
                      title: AppStrings.search,
                      textColor: AppColors.lightWhite,
                    ),

                  ],
                ),
              ),
            );
        }
      }),
    );
  }
}
