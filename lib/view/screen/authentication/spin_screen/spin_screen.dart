import 'dart:async';
import 'package:final_movie/controller/following_controller/following_controller.dart';
import 'package:final_movie/controller/streaming_controller/streaming_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpinScreen extends StatefulWidget {
  const SpinScreen({super.key});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> {
  final List selectedMovies =
      Get.arguments ?? []; // Ensure selectedMovies is not null
  final StreamController<int> selected = StreamController<
      int>.broadcast(); // Broadcast stream for multiple listeners
  final StreamingController streamingController =
      Get.find<StreamingController>();
  final FollowingController followingController =
      Get.find<FollowingController>();

  final TextEditingController genreController =
      TextEditingController(); // Controller for genre input

  int selectedIndex = 0; // Store the selected index
  List<String> selectedProviderIds = []; // Track multiple selected provider IDs
  String? selectedActorId; // Track selected actor ID for border color

  @override
  void dispose() {
    selected.close();
    genreController.dispose(); // Dispose of the genre controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,

      ),
      backgroundColor: AppColors.spinBackgroundColor,
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 8,left: 8),
            child: Column(

              children: [
                const CustomText(
                  text: 'Select Streaming',
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  bottom: 7,
                ),

                ///========================== Selected Studios ==========
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      selectedMovies.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              String providerId =
                                  selectedMovies[index]['providerId'];
                              if (selectedProviderIds.contains(providerId)) {
                                selectedProviderIds.remove(providerId);
                              } else {
                                selectedProviderIds.add(providerId);
                              }
                            });
                            print(
                                "Selected Movie providerIds: $selectedProviderIds");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedProviderIds.contains(
                                        selectedMovies[index]['providerId'])
                                    ? AppColors.genreUnselectedColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                CustomNetworkImage(
                                  imageUrl: selectedMovies[index]['logo'] ??
                                      AppConstants.movieImage,
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(height: 10),
                                CustomText(
                                  text: selectedMovies[index]['name'] ??
                                      'No Movie Selected',
                                  color: AppColors.lightWhite,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 8.h),
                CustomText(
                  text: 'Your Favorite Actor',
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                SizedBox(height: 8.h),

                ///============================All Actors====================
                if (followingController.flowData.value.actors == null ||
                    followingController.flowData.value.actors!.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomText(
                      text:
                          'You have no favorite actors.\n Follow some actors to see them here!',
                      color: AppColors.yesButtonColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                else
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        followingController.flowData.value.actors!.length,
                        (index) {
                          var data =
                              followingController.flowData.value.actors![index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedActorId = data.id; // Select actor
                              });
                              print("Selected Actor ID: $selectedActorId");
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedActorId == data.id
                                      ? AppColors.genreUnselectedColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  CustomNetworkImage(
                                    imageUrl: data.image ?? "",
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    text: data.name ?? "",
                                    color: AppColors.lightWhite,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                SizedBox(height: 8.h),

                ///==================== Display Selected Movie Title ============
                if (streamingController.streamingActorSelectList.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 4,
                        child: CustomText(
                          text:' Movie Name :',
                          color: AppColors.lightWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          text:
                              '  ${streamingController.streamingActorSelectList[selectedIndex].title ?? 'Untitled'}',
                          color: AppColors.lightWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(
                              AppRoute.movieDetails,
                              arguments: [
                                streamingController.streamingActorSelectList[selectedIndex].movieId.toString(),
                                streamingController.streamingActorSelectList[selectedIndex].rating,
                              ],
                            );
                          },
                          child: const CustomText(
                            decoration: TextDecoration.underline,
                            text:'See Details Movie',
                            color: AppColors.searchHintText,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10.w,
                      ),

                    ],
                  ),


                SizedBox(height: 15.h),

                ///==================== See Details Button  ============
                CustomButton(
                  width: MediaQuery.of(context).size.width / 4,
                  onTap: () {
                    streamingController.getMultiMovie(
                      selectedActorId: selectedActorId ?? '',
                      selectedProviderIds: selectedProviderIds,
                    );
                  },
                  title: 'See Details',
                  fillColor: AppColors.buttonColor,
                ),

                ///============================== Spin ==================
                SizedBox(
                  height: 300, // Set a fixed height for FortuneWheel
                  child: (selectedProviderIds.isEmpty ||
                          selectedActorId == null)
                      ? const Center(
                          child: CustomText(
                            text:
                                'Please select a streaming service\n and your favorite actor.',
                            color: AppColors.lightWhite,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        )
                      : (streamingController.streamingActorSelectList.length <=
                              1)
                          ? const Center(
                              child: CustomText(
                                text: 'Not enough data to spin the wheel.',
                                color: AppColors.lightWhite,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                final index = Fortune.randomInt(
                                    0,
                                    streamingController
                                        .streamingActorSelectList.length);
                                selected.add(index);
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: FortuneWheel(
                                duration: const Duration(seconds: 5),
                                selected: selected.stream,
                                items: [
                                  for (var i = 0;
                                      i <
                                          streamingController
                                              .streamingActorSelectList.length;
                                      i++)
                                    FortuneItem(
                                      style: FortuneItemStyle(
                                        color: i % 2 == 0
                                            ? AppColors.spinColor
                                            : AppColors.spinColor2,
                                      ),
                                      child: CustomText(
                                        text: streamingController
                                                .streamingActorSelectList[i]
                                                .title ??
                                            'Untitled',
                                        color: AppColors.lightWhite,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
