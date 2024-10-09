import 'package:final_movie/controller/calendar_controller/calendar_controller.dart';
import 'package:final_movie/controller/movie_details_controller/movie_details_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/model/actor_details_model/actor_details_model.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_image_text/custom_image_text.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActorDetails extends StatefulWidget {
  const ActorDetails({super.key});

  @override
  State<ActorDetails> createState() => _ActorDetailsState();
}

class _ActorDetailsState extends State<ActorDetails> {
  final CustomWidgets customWidget = CustomWidgets();
  final MovieDetailsController movieDetailsController =
  Get.find<MovieDetailsController>();
  final CalendarController calendarController = Get.find<CalendarController>();

  final String id = Get.arguments.toString(); // Ensure id is converted to a string

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
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.fromRgb,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.borderRgb),
                  ),
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        boxShape: BoxShape.circle,
                        imageUrl: data.profilePath ?? "",
                        height: 97,
                        width: 142,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            text: data.name ?? "",
                            color: AppColors.lightWhite,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            bottom: 7,
                          ),
                          Obx(
                                () => GestureDetector(
                              onTap: () {
                                movieDetailsController.toggleActorFlow(id);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 40.h,
                                width: 114.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.blackDeep,
                                ),
                                child: Row(
                                  children: [
                                    CustomImage(
                                      imageSrc: movieDetailsController.isFollowed.value
                                          ? AppIcons.unFollow
                                          : AppIcons.profileSelected,
                                    ),
                                    CustomText(
                                      left: 10,
                                      text: movieDetailsController.isFollowed.value
                                          ? AppStrings.unfollow
                                          : AppStrings.follow,
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///===================================Upcoming movies====================
                customWidget.customRow(
                  startTitle: AppStrings.upcomingMovie,
                  endTitle: AppStrings.viewAll,
                  onTap: () {
                    List<Movie> upcomingMovies = data.upcomingMovies ?? [];
                    Get.toNamed(AppRoute.actorMovie, arguments: upcomingMovies);
                  },
                ),
                SizedBox(height: 16.h),

                data.upcomingMovies == null || data.upcomingMovies!.isEmpty
                    ? SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
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
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.upcomingMovies?.length ?? 0,
                    itemBuilder: (context, index) {
                      var upcomingData = data.upcomingMovies?[index];
                      return customWidget.customUpcomingMovies(
                        onTap: () {
                          showDialogBox(context, upcomingData?.id.toString() ?? "");
                        },
                        image: upcomingData?.posterPath ?? "",
                        movieName: upcomingData?.title ?? "",
                        releaseDate: upcomingData?.releaseDate.toString() ?? "",
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
                    List<Movie> popularWork = data.popularMovies ?? [];
                    Get.toNamed(AppRoute.actorMovie, arguments: popularWork);
                  },
                ),
                SizedBox(height: 16.h),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      data.popularMovies?.length ?? 0,
                          (index) {
                        var popularData = data.popularMovies?[index];
                        return CustomImageText(
                          image: popularData?.posterPath ?? "",
                          movieName: popularData?.title ?? "",
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void showDialogBox(BuildContext context, String actorId) {
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

              Obx(() => calendarController.isAdded.value
                  ? const CustomLoader()
                  : CustomButton(
                onTap: () {
                  calendarController.addedCalender(
                      id: actorId,
                      date: DateConverter.calender(calendarController.selectedDate.value));
                },
                fillColor: AppColors.buttonColor,
                title: 'Added Calendar',
              )),
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
