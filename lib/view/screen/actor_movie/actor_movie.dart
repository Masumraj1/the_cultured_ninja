import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/model/actor_details_model/actor_details_model.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
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
                  showDialogBox(context,data?.id.toString()??"");
                },
                  image: data?.posterPath??"",
                  movieName:data?.title??"",
                  releaseDate: DateConverter.formatDate(data?.releaseDate.toString()),
                  button: AppStrings.addToCalender);
            }),
      ),
    );
  }


  void showDialogBox(BuildContext context, String actorId) { // Add actorId parameter
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        content: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              ///==========================added ===============
              CustomTextField(
                textEditingController: TextEditingController(
                  text: DateConverter.formatDate(calendarController.selectedDate.value),
                ),
                fillColor: AppColors.lightWhite,
                fieldBorderColor: AppColors.fromRgb,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: const Icon(Icons.calendar_month),
                ),
              ),
              CustomText(
                top: 15,
                maxLines: 3,
                fontSize: 14.sp,
                text: AppStrings.thankYou,
                fontWeight: FontWeight.w400,
                color: AppColors.lightWhite,
                bottom: 10,
              ),
              SizedBox(height: 15.h),

              calendarController.isAdded.value
                  ? const CustomLoader()
                  : CustomButton(
                onTap: () {

                  calendarController.addedCalender(id: actorId, date:
                  DateConverter.calender(calendarController.selectedDate.value)); // Use the passed actorId
                },
                fillColor: AppColors.buttonColor,
                title: 'Added Calendar',
              ),
            ],
          );
        }),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: calendarController.selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Update the selected date in the controller
      calendarController.selectedDate.value = picked;
    }
  }
}
