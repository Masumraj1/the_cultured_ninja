import 'package:final_movie/controller/notification_controller/notification_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///=============================== Notification AppBar =====================
      appBar: AppBar(
        backgroundColor: AppColors.blackDeep,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        title: CustomText(
          text: AppStrings.notifications,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        switch (notificationController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              notificationController.getNotification();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                notificationController.getNotification();
              },
            );

          case Status.completed:
            if (notificationController.notificationList.isEmpty) {
              return const Center(
                child: CustomText(
                  text: 'No Notification Found',
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightWhite,
                  fontSize: 16,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(notificationController.notificationList.length, (index) {
                      var data = notificationController.notificationList[index];
                      return customFollowing(
                        image: data.movie?.poster ?? "",
                        movieName: data.movie?.title ?? 'No Title',
                        title: data.title ?? "No Title",
                        onTap: () {},
                      );
                    }),
                  ),
                ),
              );
            }
        }
      }),
    );
  }

  Widget customFollowing({
    required String image,
    required String movieName,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 3,
          text: title,
          color: AppColors.lightWhite,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          bottom: 7,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl: image,
              height: 97,
              width: 142,
            ),
            SizedBox(
              width: 142,
              child: CustomText(
                left: 20,
                textAlign: TextAlign.start,
                maxLines: 10,
                text: movieName,
                color: AppColors.lightWhite,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                bottom: 7,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
