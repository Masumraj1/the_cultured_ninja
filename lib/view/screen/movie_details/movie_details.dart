import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/controller/movie_details_controller/movie_details_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  ///============================CustomWidgets========================
  final CustomWidgets customWidget = CustomWidgets();

  final MovieDetailsController homeController = Get.find<MovieDetailsController>();

  final id = Get.arguments[0]; // The movie ID
  final rating = Get.arguments[1]; // The movie ID

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.movieDetails(id: id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///==========================AppBar==========================
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
          text: AppStrings.movieDetails,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),

      ///====================================Body=============================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          switch (homeController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();

            case Status.internetError:
              return GeneralErrorScreen(
                onTap: () {
                  homeController.movieDetails(id: id);
                },
              );

            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  homeController.movieDetails(id: id);
                },
              );

            case Status.completed:
              var data = homeController.moviesDetailsModel;
              var dataDetails = homeController.moviesDetailsModel.value.details;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///==============================Poster Image=============
                    CustomNetworkImage(
                      borderRadius: BorderRadius.circular(14),
                      imageUrl: dataDetails?.backdropPath ?? '',
                      height: 241.h,
                      width: double.infinity,
                    ),
                    SizedBox(height: 14.h),

                    ///=========================Follow button======================
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.buttonColor,
                      ),
                      height: 50.h,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: homeController.toggleFavorite,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: AppStrings.addToFavorite,
                                color: AppColors.lightWhite,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                right: 10,
                              ),
                              Icon(
                                homeController.isFavorite.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.lightWhite,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///========================Overview================
                    CustomText(
                      top: 26,
                      textAlign: TextAlign.start,
                      text: dataDetails?.overview ?? "",
                      fontSize: 18.sp,
                      maxLines: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                      bottom: 12,
                    ),

                    ///==================Watched Button==============
                    Row(
                      children: [
                        const Icon(Icons.timelapse, color: Colors.white),
                        SizedBox(width: 10.w),

                        ///=====================RunTime============
                        CustomText(
                          text: dataDetails?.runtime != null
                              ? '${dataDetails?.runtime} min'
                              : 'N/A',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.lightWhite,
                        ),
                        SizedBox(width: 10.w),
                        const Icon(Icons.star, color: Colors.amber),

                        ///======================Rating=============
                        CustomText(
                          left: 8,
                          text: rating.toString(),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.lightWhite,
                        ),
                        const Spacer(),

                        ///=======================Watch Button===============
                        homeController.isTap.value
                            ? CustomButton(
                                width: 87,
                                onTap: homeController.toggleTap,
                                title: "Watched",
                                fillColor: AppColors.lightWhite,
                                textColor: AppColors.buttonColor,
                              )
                            : CustomButton(
                                width: 87,
                                onTap: homeController.toggleTap,
                                title: 'Watched',
                                fillColor: AppColors.buttonColor,
                                textColor: AppColors.lightWhite,
                              ),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    ///================Release Date and Genre================
                    const CustomText(
                      bottom: 10,
                      text: AppStrings.releaseDate,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.lightWhite,
                    ),
                    Row(
                      children: [
                        ///============================ReleaseDate==========
                        CustomText(
                          text: DateConverter.formatDate(
                              dataDetails?.releaseDate ?? "1970-01-01"),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.lightWhite,
                        ),
                        const Spacer(),
                      ],
                    ),
                    const CustomText(
                      top: 10,
                      text: 'Genre',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.lightWhite,
                    ),

                    ///=======================Genre list===========
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          dataDetails?.genres?.length ?? 0,
                          // Ensure genres is a list
                          (index) {
                            return Container(
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: AppColors.genreUnselectedColor),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: CustomText(
                                text: dataDetails?.genres?[index].name ?? "",
                                // Safely access the genre name
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.lightWhite,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    ///==================Synopsis======================
                    CustomText(
                      top: 16,
                      text: AppStrings.synopsis,
                      fontSize: 16.sp,
                      bottom: 8,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                    ),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: dataDetails?.tagline ?? "",
                      fontSize: 12.sp,
                      maxLines: 5,
                      bottom: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightWhite,
                    ),

                    ///================Available Platform================
                    CustomText(
                      text: AppStrings.availablePlatform,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                      bottom: 16,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            data.value.platform?.length ?? 0, (index) {
                          var platformList = data.value.platform?[index];
                          return customWidget.customImageText(
                              image: platformList?.logoPath ?? "",
                              movieName: platformList?.providerName ?? "");
                        }),
                      ),
                    ),
                    SizedBox(height: 15.h),

                    ///================Actor and Director================
                    CustomText(
                      text: AppStrings.actorsAndDirector,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightWhite,
                      bottom: 16,
                    ),
                    // Get.toNamed(AppRoute.actorDetails);
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          data.value.actors?.length ?? 0,
                          // Ensure it's not null
                          (index) {
                            return GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoute.actorDetails);
                              },
                              child: customWidget.customActorAndDirector(
                                image: data.value.actors?[index].profilePath ??
                                    "", // Safely handle profilePath being null
                                title: data.value.actors?[index].name ??
                                    "", // Use a default if name is null
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    ///================Related Movies================
                    customWidget.customRow(
                      startTitle: AppStrings.relatedMovies,
                      endTitle: AppStrings.viewAll,
                      onTap: () {
                        Get.toNamed(AppRoute.allMovies);
                      },
                    ),
                    SizedBox(height: 16.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(data.value.similarMovies?.length??0, (index) {
                          var similarMovies = data.value.similarMovies?[index];
                          return customWidget.customImageText(
                              image: similarMovies?.posterPath??"",
                              movieName: similarMovies?.title??" no name");
                        }),
                      ),
                    )
                  ],
                ),
              );
          }
        }),
      ),
    );
  }
}
