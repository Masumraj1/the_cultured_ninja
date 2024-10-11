import 'package:final_movie/controller/genarel_controller/genarel_controller.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_delete_dialoge/custom_delete_dialoge.dart';
import 'package:final_movie/view/widgets/custom_favorite_widget/custom_favorite_widget.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings/app_strings.dart';
import '../../widgets/custom_text/custom_text.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final CustomWidgets customWidget = CustomWidgets();

  final GeneralController generalController = Get.find<GeneralController>();

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
              text: AppStrings.history,
              fontSize: 20.sp,
              color: AppColors.lightWhite,
              fontWeight: FontWeight.w500),
          centerTitle: true,
        ),
        body: Obx(() {
          switch (generalController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader(); // Show loading indicator

            case Status.internetError:
              return NoInternetScreen(onTap: () {
                generalController.getHistory();
              });

            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  generalController
                      .getHistory(); // Retry fetching data on error
                },
              );

            case Status.completed:

              return   generalController.historyList.isEmpty?const Center(
                child: CustomText
                  (text: 'No Histoy Founded', color: AppColors
                    .lightWhite, fontWeight: FontWeight.w500, fontSize: 16, ),
              ):Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                child: ListView.builder(
                  itemCount: generalController.historyList.length,
                  itemBuilder: (context, index) {
                    var data = generalController.historyList[index];
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: CustomFavoriteWidget(
                          isDate: true,
                          image: data.poster ?? "",
                          movieName: data.title ?? "",
                          releaseDate: DateConverter.formatDate(
                              data.releaseDate ?? "2025"),
                          isExpanded: true,
                          // or false depending on the condition
                          onTap: () {
                            showCustomDeleteDialog(
                              context,
                                  () {
                                generalController.removeHistory(
                                    id: data.movieId.toString() ?? "");
                              },
                            );
                          }, date: '',
                        ));
                  },
                ),
              );
          }
        }));
  }
}
