import 'package:final_movie/controller/favorite_controller/favorite_controller.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_delete_dialoge/custom_delete_dialoge.dart';
import 'package:final_movie/view/widgets/custom_favorite_widget/custom_favorite_widget.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
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
        backgroundColor: AppColors.backgroundColor,

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
        body: Obx(() {
          switch (favoriteController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader(); // Show loading indicator

            case Status.internetError:
              return NoInternetScreen(onTap: () {
                favoriteController.getFavorite();
              });

            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  favoriteController
                      .getFavorite(); // Retry fetching data on error
                },
              );

            case Status.completed:
              return favoriteController.favoriteList.isEmpty
                  ? const Center(
                      child: CustomText(
                      text: 'No Favorite Movie Added',
                      color: AppColors.lightWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                    ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 23, vertical: 13),
                      child: ListView.builder(
                        itemCount: favoriteController.favoriteList.length,
                        itemBuilder: (context, index) {
                          var data = favoriteController.favoriteList[index];
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: CustomFavoriteWidget(
                                image: data.movie?.poster ?? "",
                                movieName: data.movie?.title ?? "",
                                releaseDate: DateConverter.formatDate(
                                    data.movie?.releaseDate ?? ""),
                                isExpanded: true,
                                // or false depending on the condition
                                onTap: () {
                                  showCustomDeleteDialog(
                                    context,
                                    () {
                                      favoriteController.addFavorite(
                                          id: data.movie?.id ?? "");
                                    },
                                  );
                                },
                              ));
                        },
                      ));
          }
        }));
  }
}
