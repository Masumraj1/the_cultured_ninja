import 'dart:io';

import 'package:final_movie/controller/profile_controller/profile_controller.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:final_movie/view/widgets/custom_profile_edit/custom-edit_profile.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  ///================================Custom EditProfile===================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///<<<<========================================EditProfile AppBar======================================
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
          text: AppStrings.editProfile,
          color: AppColors.lightWhite,
          fontSize: 18.sp,
        ),
        centerTitle: true,
      ),
      body: Obx(
         () {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///<<<<========================================Edit Image======================================

                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        profileController.selectImage();
                      },
                      child: profileController.image.isNotEmpty
                          ? Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(profileController.image.value),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CustomImage(
                                imageSrc: AppImages.man,
                                imageType: ImageType.png,
                                size: 100.sp,
                              ),
                            ),
                    ),
                  ),

                  ///<<<<========================================Name======================================

                  CustomText(
                    text: "Cameron Williamson",
                    color: AppColors.lightWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    bottom: 7,
                    top: 12,
                  ),

                  ///<<<<========================================Email======================================

                  CustomText(
                    text: "deanna.curtis@example.com",
                    color: AppColors.lightWhite,
                    fontSize: 14.sp,
                    bottom: 27,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.fromRgb,
                      border: Border.all(
                        color: AppColors.borderDrawer,
                        width: 2.0,
                        style: BorderStyle.solid, // Specify the border style
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///========================personal information==================
                        CustomText(
                          text: AppStrings.personalInformation,
                          color: AppColors.textNormalPerPal,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          bottom: 16,
                        ),

                        ///==================================Name===================
                        CustomEditProfile(
                            title: AppStrings.name,
                            controller: profileController.nameController),

                        ///=================================phone Number=================

                        CustomText(
                          color: AppColors.lightWhite,
                          text: AppStrings.phoneNumber,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.w,
                          bottom: 13,
                        ),
                        CustomTextField(
                          textEditingController: profileController.phoneController,
                          inputTextStyle:
                              const TextStyle(color: AppColors.lightWhite),
                          fillColor: AppColors.fromRgb,
                          fieldBorderColor: AppColors.borderDrawer,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),

                        ///===============================Email ========================
                        CustomEditProfile(
                            title: AppStrings.email,
                            controller: profileController.emailController),

                        ///====================================Address====================
                        CustomEditProfile(
                            title: AppStrings.address,
                            controller: profileController.addressController),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),

                  ///<<<<========================================Save And Update Button======================================

                  profileController.isUpdateLoading.value
                      ? const CustomLoader()
                      : CustomButton(
                          onTap: () {
                            profileController.userProfileEdit();
                          },
                          title: AppStrings.save,
                          fillColor: AppColors.buttonColor,
                        )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
