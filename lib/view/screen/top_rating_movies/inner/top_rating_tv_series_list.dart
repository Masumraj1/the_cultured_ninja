import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopRatingTvSeriesList extends StatelessWidget {
   TopRatingTvSeriesList({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(homeController.tvSeriesList.length, (index) {
        return customWidget.customTopRatingMovies(
          image: homeController.tvSeriesList[index],
          movieName: 'Bad Boy',
          ratings: '4.5',
        );
      }),
    );
  }
}