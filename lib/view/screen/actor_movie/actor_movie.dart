import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/model/actor_details_model/actor_details_model.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActorMovie extends StatelessWidget {
  ActorMovie({super.key});

  final CalendarController calendarController = Get.find<CalendarController>();
  final CustomWidgets customWidget = CustomWidgets();
  final List<Movie>? movies = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
          text: AppStrings.actorMovies,
          fontWeight: FontWeight.w500,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: movies == null || movies!.isEmpty
            ? Center(
          child: CustomText(
            text: "No movies found",
            color: AppColors.lightWhite,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        )
            : ListView.builder(
          itemCount: movies?.length ?? 0,
          itemBuilder: (context, index) {
            var data = movies?[index];
            return customWidget.customActorMovie(
              image: data?.posterPath ?? "",
              movieName: data?.title ?? "",
              releaseDate: DateConverter.formatDate(data?.releaseDate.toString()),
            );
          },
        ),
      ),
    );
  }




}
