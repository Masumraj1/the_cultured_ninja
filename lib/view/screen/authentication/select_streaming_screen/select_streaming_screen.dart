import 'package:final_movie/controller/streaming_controller/streaming_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectStreamingScreen extends StatefulWidget {
  const SelectStreamingScreen({super.key});

  @override
  _SelectStreamingScreenState createState() => _SelectStreamingScreenState();
}

class _SelectStreamingScreenState extends State<SelectStreamingScreen> {
  final StreamingController streamingController = Get.find<StreamingController>();
  List<int> selectedIndexes = []; // List to store selected streaming services' indexes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///========================= Selected Streaming AppBar==============
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        centerTitle: true,
        title: const CustomText(
          text: 'Select Streaming',
          color: AppColors.lightWhite,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: Obx(() {
        switch (streamingController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(
              onTap: () {
                streamingController.getAllStudio();
              },
            );
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                streamingController.getAllStudio(); // Retry fetching profile on error
              },
            );
          case Status.completed:
            return Column(
              children: [
                ///===========================All Movie List==============
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: streamingController.streamList.length,
                      itemBuilder: (context, index) {
                        var data = streamingController.streamList[index];
                        bool isSelected = selectedIndexes.contains(index); // Check if this item is selected

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedIndexes.remove(index); // Unselect if already selected
                              } else {
                                selectedIndexes.add(index); // Add to selected list
                              }
                            });
                            print('Selected===========================${selectedIndexes}');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor, // Default background
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? AppColors.genreUnselectedColor : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomNetworkImage(
                                  imageUrl: data.logo?.replaceAll(r'\\', '/') ?? "",
                                  height: 48,
                                  width: 48,
                                ),
                                const SizedBox(height: 10),
                                CustomText(
                                  text: data.name ?? "", // Name for each option
                                  color: AppColors.lightWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                ///================================Next Button==============
                CustomButton(
                  width: MediaQuery.of(context).size.width / 1.1,
                  onTap: () {
                    if (selectedIndexes.isEmpty) {
                      toastMessage(message: 'Please select at least one streaming service');
                    } else {
                      // Prepare list of selected services (names and images)
                      var selectedMovies = selectedIndexes.map((index) {
                        var movie = streamingController.streamList[index];
                        return {
                          "name": movie.name,
                          "logo": "${ApiUrl.baseUrl}/${movie.logo?.replaceAll(r'\\', '/')}"
                        };
                      }).toList();

                      // Pass the selected movies to the next screen
                      Get.toNamed(AppRoute.spinScreen, arguments: selectedMovies);
                    }
                  },
                  fillColor: AppColors.buttonColor,
                  title: 'Next',
                ),
                const SizedBox(height: 20),
              ],
            );
          default:
            return const SizedBox.shrink(); // Fallback for unknown status
        }
      }),
    );
  }
}
