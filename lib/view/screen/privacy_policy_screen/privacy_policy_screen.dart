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

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<PrivacyPolicyScreen> {
  GeneralController controller = Get.find<GeneralController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPrivacy();
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
          text: AppStrings.privacyPolicy,
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
              controller.getPrivacy();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getPrivacy();
              },
            );
          case Status.completed:
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: HtmlWidget(
                controller.privacyModel.data?.value ?? "",
                textStyle:
                    const TextStyle(color: AppColors.lightWhite, fontSize: 16),
              ),
            );
          default:
            return const SizedBox(); // Fallback for any unknown state
        }
      }),
    );
  }
}
