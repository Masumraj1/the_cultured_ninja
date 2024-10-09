import 'package:final_movie/controller/studios_controller/studios_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image_text/custom_image_text.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudiosDetailsScreen extends StatefulWidget {
  const StudiosDetailsScreen({super.key});

  @override
  State<StudiosDetailsScreen> createState() => _StudiosDetailsScreenState();
}

class _StudiosDetailsScreenState extends State<StudiosDetailsScreen> {
  final CustomWidgets customWidget = CustomWidgets();

  final StudiosController studiosController = Get.find<StudiosController>();

  final id = Get.arguments[0];
  final String name = Get.arguments[1];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studiosController.studioDetails(id: id);
    });
  }

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
          title: Center(
              child: Text(
            name.toString() ?? "",
            style: const TextStyle(color: AppColors.lightWhite),
          )),
        ),
        body: Obx(() {
          switch (studiosController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader(); // Show loading indicator

            case Status.internetError:
              return NoInternetScreen(onTap: () {
                studiosController.studioDetails(id: id);
              });

            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  studiosController.studioDetails(id: id);
                },
              );

            case Status.completed:
              var data = studiosController.studioModel.value;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///=========================Studio Image======================
                    CustomNetworkImage(
                        borderRadius: BorderRadius.circular(14),
                        imageUrl:
                            "${ApiUrl.networkImageUrl}${data.details?.logo ?? ""}",
                        height: 241.h,
                        width: double.infinity),
                    SizedBox(
                      height: 14.h,
                    ),

                    ///=========================Follow button======================

                    GestureDetector(
                      onTap: (){
                        studiosController.toggleWatched(id);

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: studiosController.isFollowed.value?AppColors.lightWhite:AppColors.buttonColor,
                        ),
                        height: 50.h,
                        width: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: studiosController.isFollowed.value?'Followed':"Following",
                                color:studiosController.isFollowed.value?AppColors.buttonColor:AppColors.lightWhite,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                right: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    ///=============================Studio Name ===================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          textAlign: TextAlign.start,
                          text: "Studio Name:",
                          fontSize: 18,
                          maxLines: 6,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightWhite,
                        ),
                        CustomText(
                          textAlign: TextAlign.start,
                          text: data.details?.name ?? "",
                          fontSize: 15,
                          maxLines: 6,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightWhite,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15.h,
                    ),

                    ///==============================Total Movie================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          textAlign: TextAlign.start,
                          text: 'Total Movie :',
                          fontSize: 18,
                          maxLines: 6,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightWhite,
                        ),
                        CustomText(
                          textAlign: TextAlign.start,
                          text: data.details?.totalMovies.toString() ?? "",
                          fontSize: 15,
                          maxLines: 6,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightWhite,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    ///==================================related Studios====================
                    customWidget.customRow(
                        startTitle: AppStrings.relatedStudios,
                        endTitle: AppStrings.viewAll,
                        onTap: () {
                          Get.toNamed(AppRoute.studiosScreen);
                        }),

                    SizedBox(
                      height: 25.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            data.relatedStudios?.length ?? 0, (index) {
                          var relatedData = data.relatedStudios?[index];
                          return CustomImageText(
                              image:
                                  "${ApiUrl.networkImageUrl}${relatedData?.logo ?? ""}",
                              movieName: relatedData?.name ?? "");
                        }),
                      ),
                    )
                  ],
                )),
              );
          }
        }));
  }
}
