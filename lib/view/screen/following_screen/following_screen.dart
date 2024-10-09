import 'package:final_movie/controller/following_controller/following_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/following_screen/inner_widgets/following_studios.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'inner_widgets/following_actor.dart';
import 'inner_widgets/tabBar_widget.dart';

class FollowingScreen extends StatelessWidget {
   FollowingScreen({super.key});

  final CustomWidgets customWidget = CustomWidgets();
final FollowingController followingController = Get.find<FollowingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const NavBar(currentIndex: 1),
      ///============================Flowing screen Appbar======================
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
          text: AppStrings.following,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        switch (followingController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
             followingController.getFlowing();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                followingController.getFlowing();
              },
            );

          case Status.completed:
            return  Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///=================================Actor and studios tabBar================
                      FollowingTabBar(followingController: followingController),
                      IndexedStack(
                        index: followingController.selectedIndex.value,
                        children: [
                          ///========================Actor========================
                          FollowingActor(customWidget: customWidget),

                          ///==========================Studio=================
                          FollowingStudios(customWidget: customWidget)
                        ],
                      )

                    ],
                  ),
                )
            );

        }
      })


    );
  }
}


