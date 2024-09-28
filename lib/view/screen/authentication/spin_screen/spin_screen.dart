import 'dart:async';
import 'package:final_movie/controller/streaming_controller/streaming_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpinScreen extends StatefulWidget {
  const SpinScreen({super.key});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> {
  final List selectedMovies = Get.arguments; // List of selected movies
  final StreamController<int> selected = StreamController<int>.broadcast(); // Broadcast stream for multiple listeners
  final StreamingController streamingController = Get.find<StreamingController>();

  // State variable to store the selected index
  int selectedIndex = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back(); // Go back on button press
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        centerTitle: true,
        title: const CustomText(
          text: 'Select Genre',
          color: AppColors.lightWhite,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColors.spinBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading text
          const CustomText(
            top: 10,
            text: 'Spin the Wheel',
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            bottom: 10,
          ),

          ///==========================Selected Movies==========
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  selectedMovies.length.clamp(0, 4), // Ensure we don't exceed 4 items
                      (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CustomNetworkImage(
                            imageUrl: selectedMovies[index]['logo'] ?? AppConstants.movieImage,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            text: selectedMovies[index]['name'] ?? 'No Movie Selected',
                            color: AppColors.lightWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          ///===============================Movie Type==============
          Obx(() {
            if (streamingController.genreData.isEmpty) {
              return const CustomText(
                text: 'Loading...',
                color: AppColors.lightWhite,
                fontSize: 18,
              );
            } else {
              return CustomText(
                top: 10,
                text: 'Movie Type: ${streamingController.genreData[selectedIndex].name}',
                color: AppColors.lightWhite,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              );
            }
          }),

          SizedBox(height: 15.w),

          ///====================Go Button============
          CustomButton(
            width: MediaQuery.of(context).size.width / 4,
            onTap: () {
              Get.toNamed(AppRoute.homeScreen);
            },
            title: 'Go',
            fillColor: AppColors.buttonColor,
          ),

          ///==============================Spin ==================
          Expanded(
            child: Obx(() {
              if (streamingController.genreData.length <= 1) {
                return const Center(
                  child: CustomText(
                    text: 'Not enough genres to spin the wheel.',
                    color: AppColors.lightWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    final index = Fortune.randomInt(0, streamingController.genreData.length);
                    selected.add(index);
                    setState(() {
                      selectedIndex = index; // Update the selected index
                    });
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: FortuneWheel(
                          duration: const Duration(seconds: 5),
                          selected: selected.stream,
                          items: [
                            for (var i = 0; i < streamingController.genreData.length; i++)
                              FortuneItem(
                                style: FortuneItemStyle(
                                  color: i % 2 == 0 ? AppColors.spinColor : AppColors.spinColor2,
                                ),
                                child: CustomText(
                                  text: streamingController.genreData[i].name ?? '',
                                  color: AppColors.lightWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
