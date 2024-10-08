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
      children: List.generate(homeController.moviesList.length, (index) {
        var data = homeController.moviesList[index];
        return GestureDetector(
          onTap: (){
            Get.toNamed(AppRoute.movieDetails,  arguments: [
              data.movieId.toString(),
              data.rating
            ]);
          },
          child: customWidget.customTopRatingMovies(
            image: data.poster??"",
            movieName: data.title??"",
            ratings: data.rating.toString(),
          ),
        );
      }),
    );
  }
}