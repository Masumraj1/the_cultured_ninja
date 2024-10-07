import 'package:final_movie/controller/movie_details_controller/movie_details_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
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

  final MovieDetailsController movieDetailsController =
      Get.find<MovieDetailsController>();

  final id = Get.arguments.toString(); // Ensure id is converted to a string

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieDetailsController.actorDetail(id: id);
    });
  }

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
        body: Obx(() {
          var data = movieDetailsController.actorDetails.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFollowing(
                    image: data.profilePath ?? "",
                    movieName: data.name ?? "",
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

                data.upcomingMovies == null || data.upcomingMovies!.isEmpty
                    ?                        SizedBox(
                    height: MediaQuery.of(context).size.height/2,
                        child: const Center(
                          child: CustomText(
                              text: 'No Upcoming Movies',
                              color: AppColors.lightWhite,
                              fontSize: 15,
                            fontWeight: FontWeight.w500,
                            ),
                        ),
                      )
                      : SizedBox(
                          height:MediaQuery.of(context).size.height/2 ,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetailsController
                                .actorDetails.value.upcomingMovies?.length,
                            itemBuilder: (context, index) {
                              var  upcomingData = movieDetailsController.actorDetails.value.upcomingMovies?[index];
                              return customWidget.customUpcomingMovies(
                                onTap: () {
                                  showDialogBox(context);
                                },
                                image: upcomingData?.posterPath??"",
                                movieName: upcomingData?.title??"",
                                releaseDate: upcomingData?.releaseDate.toString()??"",
                                button: AppStrings.addToCalender,
                              );
                            },
                          ),
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

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          movieDetailsController
                                  .actorDetails.value.popularMovies?.length ??
                              0, (index) {
                        var data = movieDetailsController
                            .actorDetails.value.popularMovies?[index];
                        return customWidget.customImageText(
                          image: data?.posterPath ?? "",
                          movieName: data?.title ?? "",
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  void showDialogBox(BuildContext context) {
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
                      ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),

              ///==========================added ===============

              CustomTextField(
                textEditingController: TextEditingController(
                    text: DateConverter.estimatedDate(selectedDate)),
                fillColor: AppColors.fromRgb,
                fieldBorderColor: AppColors.fromRgb,
                suffixIcon: GestureDetector(
                    onTap: () {
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

              // calendarController.isAdded.value?const CustomLoader():
              CustomButton(
                onTap: () {
                  // calendarController.addedCalender(id: '');
                },
                fillColor: AppColors.buttonColor,
                title: 'Added Calender',
              )
            ],
          );
        }),
      ),
    );
  }
}
