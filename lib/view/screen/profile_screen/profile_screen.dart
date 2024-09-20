import 'package:final_movie/controller/profile_controller/profile_controller.dart';
import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/services/app_url.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_profile/custom_profile.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/genarel_error/genarel_error.dart';
import 'package:final_movie/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const NavBar(currentIndex: 4),

      ///======================== Profile AppBar=================
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoute.editProfileScreen);
            },
            child: const CustomImage(
              imageSrc: AppIcons.edit,
              imageType: ImageType.svg,
            ),
          ),
          const SizedBox(width: 10),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.blackDeep,
        title: CustomText(
          text: AppStrings.profile,
          color: AppColors.lightWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        var data = profileController.profileModel.value;
        switch (profileController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return const CustomLoader();
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                profileController.getProfile();
              },
            );
          case Status.completed:
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl:
                      (profileController.profileModel.value.img != null &&
                          profileController.profileModel.value.img!.isNotEmpty)
                          ? ((profileController.profileModel.value.img?.startsWith('https') ?? false)
                          ? profileController.profileModel.value.img ?? ""
                          : "${ApiUrl.baseUrl}${profileController.profileModel.value.img?.replaceAll('\\', '/') ?? ""}")
                          :AppConstants.onlineImage,
                       // Placeholder image when img is empty
                      height: 78.h,
                      width: 84.w,
                    ),



                    /// Name
                    CustomText(
                      text: data.name ?? '',
                      color: AppColors.lightWhite,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 7,
                      top: 12,
                    ),

                    /// Email
                    CustomText(
                      text: data.email ?? '',
                      color: AppColors.lightWhite,
                      fontSize: 14.sp,
                      bottom: 27,
                    ),

                    /// Personal Info Container
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.fromRgb,
                        border: Border.all(
                          color: AppColors.borderDrawer,
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppStrings.personalInformation,
                            color: AppColors.textNormalPerPal,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            bottom: 16,
                          ),

                          /// Name
                          CustomProfile(
                            title: AppStrings.name,
                            subTitle: data.name ?? '',
                          ),

                          /// Phone Number
                          CustomProfile(
                            title: AppStrings.phoneNumber,
                            subTitle: data.phone.toString(),
                          ),


                          /// Email
                          CustomProfile(
                            title: AppStrings.email,
                            subTitle: data.email ?? '',
                          ),

                          /// Address
                          CustomProfile(
                            title: AppStrings.address,
                            subTitle: data.address ?? "Add Your Address",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      }),
    );
  }
}
