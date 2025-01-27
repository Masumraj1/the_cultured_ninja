import 'package:final_movie/controller/global_controller/global_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/helpar/shared_prefe/shared_prefe.dart';
import 'package:final_movie/helpar/toast_message/toast_message.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/parmission_button/parmission_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});



  final GlobalController globalController = Get.find<GlobalController>();




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
        color: AppColors.backgroundColor,
      ),
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        children: [
          ///================================ APP LOGO ==============================///
          Container(
            height: MediaQuery.of(context).size.height / 5,
            color: AppColors.newColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: CustomImage(
                imageSrc: AppImages.icons,
                imageType: ImageType.png,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, right: 20.w),
                child: Column(
                  children: [
                    ///=======================Profile =====================

                    customRow(
                        image: AppIcons.user,
                        title: AppStrings.profile,
                        onTap: () {
                          Get.toNamed(AppRoute.profileScreen);
                        }),

                    ///==============================Settings =====================
                    customRow(
                        image: AppIcons.settings,
                        title: AppStrings.settings,
                        onTap: () {
                          Get.toNamed(AppRoute.settingScreen);
                        }),

                    ///==============================Privacy Policy =====================
                    customRow(
                        image: AppIcons.privacy,
                        title: AppStrings.privacyPolicy,
                        onTap: () {
                          Get.toNamed(AppRoute.privacyPolicyScreen);
                        }),

                    ///======================Terms and condition ===============
                    customRow(
                        image: AppIcons.privacy,
                        title: AppStrings.termsAndCondition,
                        onTap: () {
                          Get.toNamed(AppRoute.termsAndCondition);
                        }),

                    ///======================History===============
                    customRow(
                        image: AppIcons.home,
                        title: AppStrings.history,
                        onTap: () {
                          Get.toNamed(AppRoute.historyScreen);
                        }),

                    ///======================Payment===============
                    Obx(
                       () {
                        return customRow(
                          image: AppIcons.premium,
                          title: globalController.isPayment.value ? "Premium Activated" : "Go Premium",
                          onTap: () async {

                            if (globalController.isPayment.value==false) {
                              Get.toNamed(AppRoute.paymentScreen);
                            } else {
                              toastMessage(message: 'Payment Already Completed');
                            }
                          },
                        );
                      }
                    ),


                  ///======================Spin===============
                    customRow(
                        image: AppIcons.spin,
                        title: "Spin",
                        onTap: () {
                          Get.toNamed(AppRoute.selectStreamingScreen);
                        }),

                    ///==============================Sign Out======================

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.9,
                    ),
                    customRow(
                        image: AppIcons.logOut,
                        title: AppStrings.logOut,
                        onTap: () async {
                          permissionPopUp(
                              title: 'Are you sure you want to log out',
                              context: context,
                              ontapNo: () {
                                Get.back();
                              },
                              ontapYes: () async {
                                await SharePrefsHelper.remove(
                                    AppConstants.bearerToken);
                                await SharePrefsHelper.remove(
                                    AppConstants.profileID);

                                await SharePrefsHelper.remove(
                                    AppConstants.isPayment);

                                print(
                                    'remove token========================"${AppConstants.bearerToken}"');
                                print(
                                    'remove profileId========================"${AppConstants.profileID}"');
                                print(
                                    'remove IsPayment========================"${AppConstants.isPayment}"');

                                Get.toNamed(AppRoute.signInScreen);
                              });
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customRow(
      {required String image,
        required String title,
        required VoidCallback onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColors.borderDrawer),
                bottom: BorderSide(color: AppColors.borderDrawer),
                right: BorderSide(color: AppColors.borderDrawer)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 39),
            child: Row(
              children: [
                CustomImage(
                  size: 18.r,
                  imageSrc: image,
                ),
                CustomText(
                  color: AppColors.lightWhite,
                  left: 16.w,
                  text: title,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.w,
                )
              ],
            ),
          ),
        ),
      );
}
