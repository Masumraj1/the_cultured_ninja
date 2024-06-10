import 'package:final_movie/core/app_routes.dart';
import 'package:final_movie/utils/app_images/app_images.dart';
import 'package:final_movie/view/widgets/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(AppRoute.signInScreen);
    });
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            ///=============================BackGround Image========================
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AppImages.background,

                      ))),

            ),
            ///========================This is loader=====================
            const Positioned(child: CustomLoader())
          ],
        )
      ),
    );
  }
}