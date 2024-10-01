import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/view/widgets/custom_movie_card/custom_movie_card.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenTvSeries extends StatelessWidget {
   HomeScreenTvSeries({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(homeController.tvList
            .length, (index) {
          return CustomMovieCard(
            image: homeController.tvList[index].poster ??
                "",
            ratingBar: homeController.tvList[index].rating
                .toString(),
          );
        }),
      ),
    );
  }
}