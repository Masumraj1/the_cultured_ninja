import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings/app_strings.dart';
import '../../widgets/custom_text/custom_text.dart';

class FilterScreen extends StatelessWidget {
   FilterScreen({super.key});


  final CustomWidgets customWidget = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///==================================Filter Appbar ==========================
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
            text: AppStrings.filter,
            fontSize: 20.sp,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context,index) {
        return GestureDetector(
          onTap: (){
            Get.toNamed(AppRoute.movieDetails);
          },
          child: customWidget.customFilter(
              image: AppConstants.movieImage,
              movieName: 'bad boy',
              releaseDate: "10 august 2023"),
        );
      })
    );
  }
}
