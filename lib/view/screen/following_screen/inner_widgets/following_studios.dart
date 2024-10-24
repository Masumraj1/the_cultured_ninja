import 'package:final_movie/controller/following_controller/following_controller.dart';
import 'package:final_movie/controller/studios_controller/studios_controller.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FollowingStudios extends StatelessWidget {
  FollowingStudios({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;

  final FollowingController followingController =
      Get.find<FollowingController>();

  final StudiosController studiosController = Get.find<StudiosController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: List.generate(
            followingController.flowData.value.studios?.length ?? 0, (index) {
          var data = followingController.flowData.value.studios?[index];
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.fromRgb,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.borderRgb),
            ),
            child: Row(
              children: [
                CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  imageUrl: "${ApiUrl.networkImageUrl}${data?.logo ?? ""}",
                  height: 97,
                  width: 142,
                ),
                SizedBox(
                  width: 14.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      text: data?.name ?? "",
                      color: AppColors.lightWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      bottom: 7,
                    ),
                    GestureDetector(
                      onTap: () async {
                        bool isRemove = await studiosController
                            .toggleWatched(data?.id ?? "");
                        if (isRemove) {
                          followingController.flowData.value.studios
                              ?.removeAt(index);
                          followingController.flowData.refresh();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 40.h,
                        width: 114.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.blackDeep,
                        ),
                        child: Row(
                          children: [
                            const CustomImage(
                              imageSrc:
                              AppIcons.unFollow,
                            ),
                            CustomText(
                              left: 10,
                              text: AppStrings.unfollow,
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
