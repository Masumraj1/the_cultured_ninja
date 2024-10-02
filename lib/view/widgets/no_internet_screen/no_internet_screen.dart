import 'package:final_movie/core/app_routes.dart';
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi),
              const CustomText(
                  top: 40,
                  bottom: 40,
                  maxLines: 3,
                  text:'No Internet'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    fillColor:Colors.red,
                    title: "Try Again",
                    onTap: () {
                      // onTap();
                      Get.toNamed(AppRoute.signInScreen);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}