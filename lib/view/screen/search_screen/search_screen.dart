import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_search_card/custom_search_card.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///======================Search Appbar===============
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.backgroundColor,
        title: CustomText(
          text: AppStrings.search,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        switch (homeController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              homeController.getMovies(listType: MovieListType.searchMovies);
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                homeController.getMovies(listType: MovieListType.searchMovies); // Retry fetching data on error
              },
            );

          case Status.completed:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  ///===========================Search=====================
                  CustomTextField(
                    isColor: true,
                    onFieldSubmitted: (value) {
                      homeController.searchMovie(search: value);
                    },
                    textEditingController: homeController.searchController,
                    fillColor: AppColors.fromRgb,
                    fieldBorderColor: AppColors.fromRgb,
                    hintText: 'Use Coma for Multiple Search',
                    hintStyle: const TextStyle(color: AppColors.searchHintText),
                    isPrefixIcon: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.search,
                        color: AppColors.searchHintText,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  ///==========================All Movie====================
                  Expanded(
                    child: homeController.searchMovieList.isNotEmpty
                        ? ListView.builder(
                      itemCount: homeController.searchMovieList.length,
                      itemBuilder: (context, index) {
                        var data = homeController.searchMovieList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.movieDetails,  arguments: [
                              data.movieId.toString(),
                              data.rating
                            ]);
                          },
                          child: CustomSearchCard(
                            image: data.poster ?? "",
                            movieName: data.title ?? "N/A",
                            releaseDate: data.rating?.toString() ?? "N/A",
                          ),
                        );
                      },
                    )
                        : Center(
                      child: CustomText(
                        text: 'No Movie Found',
                        color: AppColors.lightWhite,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            );

          default:
            return const SizedBox(); // Fallback for unknown state
        }
      }),
    );
  }
}
