import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/screen/home_screen/home_controller/home_controller.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.tvSeriesList.length,
          itemBuilder: (context, index) {
            return customWidget.customRatingMovies(
              image: homeController.tvSeriesList[index], ratingBar: '4.5',
            );
          }),
    );
  }
}