import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_image/custom_image.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../widgets/custom_text/custom_text.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  // final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.backgroundColor,
      margin: EdgeInsets.only(
        top: 32.h,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
      child: Column(
        children: [
          ///====================================Top Section================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ///==================== Profile =====================
                  CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: AppConstants.onlineImage,
                      height: 60,
                      width: 60),


                  SizedBox(
                    width: 16.w,
                  ),
                    ///==========================Welcome back======================
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.welcomeBack,
                        color: AppColors.lightWhite,
                        fontSize: 20.sp,
                      ),
                      ///========================name=============================
                      CustomText(
                        text: AppStrings.williamson,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                        color: AppColors.lightWhite,
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  ///<==================== notification ====================>
                  IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.notificationScreen);
                      },
                      icon: const Icon(
                        Icons.notifications,
                        color: AppColors.lightWhite,
                      )),

                  ///<==================== Menu Bar ====================>
                  IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.lightWhite,
                      ))
                ],
              )
            ],
          ),

          ///====================================Search Section================================

          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
               Expanded(
                flex: 8,
                child: CustomTextField(
                    fillColor: AppColors.fromRgb,
                   onTap: (){
                      Get.toNamed(AppRoute.searchScreen);
                   },
                    fieldBorderColor: AppColors.fromRgb,
                    readOnly: true,
                    hintText: AppStrings.search,
                    hintStyle: const TextStyle(color: AppColors.searchHintText),
                    isPrefixIcon: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(Icons.search,color: AppColors.searchHintText,),
                ),
                ),
              ),
              SizedBox(
                width: 14.h,
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Get.toNamed(AppRoute.filterScreen);
                  },
                  child: Container(
                    height: 55,
                   width: 54,
                   decoration: BoxDecoration(
                       color: AppColors.fromRgb,
                       borderRadius: BorderRadius.circular(10)
                   ),
                    child: const Icon(Icons.filter_alt,size:35,color: AppColors.lightWhite,),
                  ),
                ),
              )
            ],
          ),


        ],
      ),
    );
  }
}