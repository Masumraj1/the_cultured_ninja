import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenTopRatingMovies extends StatelessWidget {
  const HomeScreenTopRatingMovies({
    super.key,
    required this.customWidget,
  });

  final CustomWidgets customWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return customWidget.customRatingMovies(
              image: AppConstants.movieImage, ratingBar: '4.5',
            );
          }),
    );
  }
}