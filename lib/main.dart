import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/app_routes.dart';
import 'core/dependency.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DependancyInjection di = DependancyInjection();
  di.dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        // theme: darkModeTheme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoute.homeScreen,
        navigatorKey: Get.key,
        getPages: AppRoute.routes,
      ),
    );
  }
}