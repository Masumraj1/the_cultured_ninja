import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/model/actor_details_model/actor_details_model.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActorMovie extends StatelessWidget {
  ActorMovie({super.key});



  final CustomWidgets customWidget = CustomWidgets();
 final List<Movie>? movies = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      ///=================================Actor movies appbar====================
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(text: AppStrings.actorMovies,fontWeight:FontWeight.w500,color: AppColors.lightWhite,fontSize: 20.sp,),centerTitle: true,),
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: ListView.builder(
            itemCount: movies?.length ?? 0,
            itemBuilder: (context,index){
              var data = movies?[index];
              return   customWidget.customActorMovie(
                onTap: (){
                  showDialogBox(context);
                },
                  image: data?.posterPath??"",
                  movieName:data?.title??"",
                  releaseDate: DateConverter.formatDate(data?.releaseDate.toString()),
                  button: AppStrings.addToCalender);
            }),
      ),
    );
  }


  void showDialogBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        content: SizedBox(
          height: 250.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const CustomImage(
                        imageSrc: AppIcons.x,
                        imageType: ImageType.svg,
                      ))
                ],
              ),

              ///==========================added ===============
              CustomText(
                maxLines: 3,
                fontSize: 18.sp,
                text: AppStrings.addedCalendarSuccessFully,
                fontWeight: FontWeight.w500,
                color: AppColors.lightWhite,
                bottom: 10,
              ),   CustomText(
                maxLines: 3,
                fontSize: 14.sp,
                text: AppStrings.thankYou,
                fontWeight: FontWeight.w400,
                color: AppColors.lightWhite,
                bottom: 10,
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomButton(onTap: (){
                Get.back();
              },
                fillColor: AppColors.buttonColor,
                title: 'Ok',
              )
            ],
          ),
        ),
      ),
    );
  }
}
