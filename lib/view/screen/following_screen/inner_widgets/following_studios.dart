import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class FollowingStudios extends StatelessWidget {
  const FollowingStudios({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(6, (index){
        return customWidget.customFollowing(
          image: AppConstants.disneyPlus,
          movieName: 'Disney Plus',);
      }),
    );
  }
}