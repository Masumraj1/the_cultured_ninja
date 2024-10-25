import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/app_routes.dart';
import 'core/dependency.dart';
import 'helpar/device_utils/device_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  MobileAds.instance.initialize();
  var deviceId = ["296f4308-6401-4ccb-b76b-a6410c65cb88"];
  RequestConfiguration requestConfiguration =
  RequestConfiguration(testDeviceIds: deviceId);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoute.onBoardingPage,
        navigatorKey: Get.key,
        getPages: AppRoute.routes,
      ),
    );
  }
}
