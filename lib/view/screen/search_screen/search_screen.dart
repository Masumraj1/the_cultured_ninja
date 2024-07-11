import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_const/app_const.dart';
import 'package:final_movie/utils/app_strings/app_strings.dart';
import 'package:final_movie/view/widgets/custom_network_image/custom_network_image.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:final_movie/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      ///======================Search Appbar===============
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.backgroundColor,
        title: CustomText(text: AppStrings.search,color: AppColors.lightWhite,fontSize: 20.sp,),centerTitle: true,),
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          children: [
            const CustomTextField(
              fillColor: AppColors.fromRgb,
              fieldBorderColor: AppColors.fromRgb,
              hintText: AppStrings.search,
              hintStyle: TextStyle(color: AppColors.searchHintText),
              isPrefixIcon: true,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.search,color: AppColors.searchHintText,),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context,index){
                    return   GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.movieDetails);
                      },
                      child: customFavorite(
                          image: AppConstants.movieImage,
                          movieName: 'Star Wars: The Rise of Skywalker (2024)',
                          releaseDate: '3h 12m', year: '2024 Action Comedy'),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  ///===========================customFavorite===============================
  Widget customFavorite({
    required String image,
    required String movieName,
    required String releaseDate,
    required String year,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.fromRgb,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderDrawer)),
      child: Row(
        children: [
          CustomNetworkImage(

            imageUrl: image,
            height: 97,
            width: 142,
          ),
          SizedBox(
            width: 14.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(

                  textAlign: TextAlign.start,
                  maxLines: 3,
                  text: movieName,
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  bottom: 7,
                ),

                CustomText(
                  text: year,
                  color: AppColors.favoriteContainerTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ), CustomText(
                  text: releaseDate,
                  color: AppColors.favoriteContainerTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
