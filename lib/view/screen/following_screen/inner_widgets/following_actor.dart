import 'package:final_movie/controller/following_controller/following_controller.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_following/custom_following.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingActor extends StatelessWidget {
   FollowingActor({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;

  final FollowingController followingController = Get.find<FollowingController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(followingController.flowData.value.actors?.length??0, (index){

        var data = followingController.flowData.value.actors?[index];
        return CustomFollowing(
            image: data?.image??"",
            movieName:data?.name??"");

      }),
    );
  }
}