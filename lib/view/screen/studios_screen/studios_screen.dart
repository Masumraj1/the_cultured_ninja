import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/app_url.dart';

class StudiosScreen extends StatelessWidget {
  StudiosScreen({super.key});

  ///============================customStudios========================
  final CustomWidgets customWidget = CustomWidgets();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
          text: AppStrings.studios,
          fontSize: 20.sp,
          color: AppColors.lightWhite,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        switch (homeController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              homeController.getStudio();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                homeController.getStudio(); // Retry fetching data on error
              },
            );

          case Status.completed:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  left: 21,
                  top: 24,
                  text: AppStrings.allStudio,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  bottom: 24,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      // childAspectRatio: 0.10, // Adjust the aspect ratio as needed
                    ),
                    itemCount: homeController.studioDataList.length,
                    itemBuilder: (context, index) {
                      var data = homeController.studioDataList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.studiosDetailsScreen,
                              arguments: [
                                data.logo,
                                data.name,
                                data.totalMovies
                              ]);
                        },
                        child: customWidget.customImageText(
                          image: "${ApiUrl.networkImageUrl}${data.logo ?? ""}",
                          movieName: data.name ?? "",
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          default:
            return const SizedBox(); // Fallback for unknown state
        }
      }),
    );
  }
}
