import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_following/custom_following.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class FollowingActor extends StatelessWidget {
  const FollowingActor({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(6, (index){
        return CustomFollowing(
            image: AppConstants.onlineImage,
            movieName: "Leonardo");

          // customWidget.customFollowing(
          // image: AppConstants.onlineImage,
          // movieName: 'Leonardo ', onTap: () {  },);
      }),
    );
  }
}