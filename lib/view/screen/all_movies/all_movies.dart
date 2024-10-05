import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
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

class AllMovies extends StatelessWidget {
  AllMovies({super.key});

  final CustomWidgets customWidget = CustomWidgets();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///==================================All Movies Appbar==================
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
          text: AppStrings.allMovies,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),

      ///==================================Body==================
      body: Obx(() {
        switch (homeController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(
              onTap: () {
                homeController.customMethod(); // Retry fetching data
              },
            );

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                homeController.customMethod(); // Retry fetching data on error
              },
            );

          case Status.completed:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ListView.builder(
                itemCount: homeController.moviesList.length,
                itemBuilder: (context, index) {
                  var data = homeController.moviesList[index];

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoute.movieDetails,
                        arguments: [data.id, data.rating],
                      );
                    },
                    child: customWidget.customMovie(
                      image: data.poster ?? "", // Ensure null safety
                      movieName: data.title ?? "Untitled", // Default value if null
                      releaseDate: DateConverter.formatDate(data.releaseDate),
                    ),
                  );
                },
              ),
            );

          default:
            return const SizedBox.shrink(); // Fallback case, just an empty widget
        }
      }),
    );
  }
}
