import 'package:final_movie/controller/following_controller/following_controller.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/view/widgets/custom_following/custom_following.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingStudios extends StatelessWidget {
  FollowingStudios({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;

  final FollowingController followingController = Get.find<
      FollowingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: List.generate(
              followingController.flowData.value.studios?.length ?? 0, (index) {
            var data = followingController.flowData.value.studios?[index];
            return CustomFollowing(
                image: "${ApiUrl.networkImageUrl}${data?.logo ?? ""}",
                movieName: data?.name ?? "");
          }),
        );
      }
    );
  }
}