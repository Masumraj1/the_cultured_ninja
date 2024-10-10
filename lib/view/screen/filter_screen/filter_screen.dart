import 'package:final_movie/controller/streaming_controller/streaming_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/date_converter/date_converter.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_widgets/custom_widgets.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings/app_strings.dart';
import '../../widgets/custom_text/custom_text.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final CustomWidgets customWidget = CustomWidgets();

  final StreamingController streamingController =
      Get.find<StreamingController>();
  final id = Get.arguments;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      streamingController.getFilter(id: id.toString());
    });
    super.initState();
  }

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
              text: AppStrings.filter,
              fontSize: 20.sp,
              color: AppColors.lightWhite,
              fontWeight: FontWeight.w500),
          centerTitle: true,
        ),
        body: Obx(() {
          switch (streamingController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader(); // Show loading indicator

            case Status.internetError:
              return NoInternetScreen(onTap: () {
                streamingController.getFilter(id: id);
              });

            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  streamingController.getFilter(id: id);
                },
              );

            case Status.completed:
              return streamingController.filterList.isEmpty
                  ? const Center(
                    child: CustomText(
                        text: 'No Movie Founded',
                        color: AppColors.lightWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                  )
                  : ListView.builder(
                      itemCount: streamingController.filterList.length,
                      itemBuilder: (context, index) {
                        var data = streamingController.filterList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.movieDetails, arguments: [
                              data.movieId.toString(),
                              data.rating
                            ]);
                          },
                          child: customWidget.customFilter(
                              image: data.poster ?? "",
                              movieName: data.title ?? "",
                              releaseDate: DateConverter.formatDate(
                                  data.releaseDate.toString())),
                        );
                      });
          }
        }));
  }
}
