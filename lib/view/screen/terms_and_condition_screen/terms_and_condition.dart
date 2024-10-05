import 'package:final_movie/controller/genarel_controller/genarel_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; // Assuming you're using this for HtmlWidget

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsAndCondition> {
  GeneralController controller = Get.find<GeneralController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getTerms();
    });
    super.initState();
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
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        centerTitle: true,
        title: CustomText(
          text: AppStrings.termsAndCondition,
          color: AppColors.lightWhite,
          fontSize: 18.sp,
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: () {
              controller.getTerms();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getTerms();
              },
            );
          case Status.completed:
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: HtmlWidget(
                controller.termsModel.data?.value ?? "",
                  textStyle:
                  const TextStyle(color: AppColors.lightWhite, fontSize: 16)
              ),
            );
          default:
            return const SizedBox(); // Fallback for any unknown state
        }
      }),
    );
  }
}
