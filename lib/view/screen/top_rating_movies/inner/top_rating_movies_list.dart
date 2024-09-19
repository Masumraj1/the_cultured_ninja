import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopRatingMoviesList extends StatelessWidget {
   TopRatingMoviesList({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;
 final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(homeController.movie.length, (index) {
        return GestureDetector(
          onTap: (){
            Get.toNamed(AppRoute.movieDetails);
          },
          child: customWidget.customTopRatingMovies(
            image: homeController.movie[index],
            movieName: 'Bad Boy',
            ratings: '4.5',
          ),
        );
      }),
    );
  }
}