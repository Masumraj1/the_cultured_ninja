import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key, required this.onTap});

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi,color: AppColors.lightWhite,),
              const CustomText(
                  top: 40,
                  fontSize: 16,
                  bottom: 40,
                  maxLines: 3,
                  text:'No Internet',color: AppColors.lightWhite,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    fillColor:AppColors.buttonColor,
                    title: "Try Again",
                    onTap: onTap),
              )
            ],
          ),
        ),
      ),
    );
  }
}