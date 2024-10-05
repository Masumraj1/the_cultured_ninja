import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
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

import '../../widgets/custom_following/custom_following.dart';

class ActorDetails extends StatefulWidget {
  const ActorDetails({super.key});

  @override
  State<ActorDetails> createState() => _ActorDetailsState();
}

class _ActorDetailsState extends State<ActorDetails> {
  final CustomWidgets customWidget = CustomWidgets();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  final CalendarController calendarController = Get.find<CalendarController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///===========================Actor details appbar=============================
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
          text: AppStrings.actorDetails,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomFollowing(
                image: AppConstants.onlineImage,
                movieName: 'Masum Raj',
              ),

              ///===================================Upcoming movies====================
              customWidget.customRow(
                  startTitle: AppStrings.upcomingMovie,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    Get.toNamed(AppRoute.actorMovie);
                  }),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 350.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return customWidget.customUpcomingMovies(
                      onTap: (){
                        showDialogBox(context);
                      },
                      image: AppConstants.movieImage,
                      movieName: "The Talented People",
                      releaseDate: '10 august 2023',
                      button: AppStrings.addToCalender,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 24.h,
              ),

              ///=========================His work=========================
              customWidget.customRow(
                  startTitle: AppStrings.hisWork,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    Get.toNamed(AppRoute.actorMovie);
                  }),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 170.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return customWidget.customImageText(
                      image: AppConstants.movieImage,
                      movieName: "The Talented People",
                    );
                  },
                ),
              ),

              ///======================================Actor and director=================
              CustomText(
                text: AppStrings.actorsAndDirector,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lightWhite,
                bottom: 16,
              ),
              SizedBox(
                height: 140.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.actorDetails);
                        },
                        child: customWidget.customActorAndDirector(
                            image: AppConstants.onlineImage,
                            title: 'actor',
                           ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        content: Obx(
           () {
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
                        ))
                  ],
                ),
                     SizedBox(height: 10.h,),
                ///==========================added ===============

                 CustomTextField(
                 textEditingController: TextEditingController(text: DateConverter.estimatedDate(selectedDate)),
                 fillColor: AppColors.fromRgb,
                  fieldBorderColor: AppColors.fromRgb,
                  suffixIcon: GestureDetector(
                      onTap: (){
                        _selectDate(context);
                      },
                      child: const Icon(Icons.calendar_month)),
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
                SizedBox(
                  height: 15.h,
                ),

                 calendarController.isAdded.value?const CustomLoader():
                CustomButton(onTap: (){
                  calendarController.addedCalender(id: '');
                },
                  fillColor: AppColors.buttonColor,
                  title: 'Added Calender',
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
