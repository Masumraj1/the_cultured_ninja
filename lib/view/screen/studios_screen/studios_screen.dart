import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/screen/studios_screen/studios_controller/studios_controller.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudiosScreen extends StatelessWidget {
   StudiosScreen({super.key});


  ///============================customStudios========================
  final CustomWidgets customWidget = CustomWidgets();


  final StudiosController studiosController = Get.find<StudiosController>();

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
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: CustomText(
            text: AppStrings.studios,
            fontSize: 20.sp,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            left: 21,
            top: 24,
            text: AppStrings.allStudio,
            color: AppColors.lightWhite,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            bottom: 24,
          ),
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: studiosController.tvSeriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Get.toNamed(AppRoute.studiosDetailsScreen);
            },
            child: customWidget.customImageText(
                image: studiosController.tvSeriesList[index],
                movieName: "Disney Plus"),
          );
        },
      )
        ],
      ),
    );
  }
}
