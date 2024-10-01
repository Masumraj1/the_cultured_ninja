import 'package:final_movie/controller/home_controller/home_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/view/widgets/custom_movie_card/custom_movie_card.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenTopRatingMovies extends StatelessWidget {
  HomeScreenTopRatingMovies({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(homeController.moviesList.length, (index) {
          var data = homeController.moviesList[index];

          return CustomMovieCard(
            onTap: () {
              Get.toNamed(AppRoute.movieDetails,
                  arguments: [
                    data.id,
                    data.rating
                  ]);
            },
            image: homeController.moviesList[index].poster ?? "",
            ratingBar: homeController.moviesList[index].rating.toString(),
          );
        }),
      ),
    );
  }
}
