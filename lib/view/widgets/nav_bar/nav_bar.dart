import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/utils/app_icons/app_icons.dart';
import 'package:final_movie/view/screen/calender_screen/calender_screen.dart';
import 'package:final_movie/view/screen/favorite_screen/favorite_screen.dart';
import 'package:final_movie/view/screen/following_screen/following_screen.dart';
import 'package:final_movie/view/screen/home_screen/home_screen.dart';
import 'package:final_movie/view/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var bottomNavIndex = 0;

  List<String> unselectedIcon = [
    AppIcons.homeUnselected,
    AppIcons.profileUnselected,
    AppIcons.calendarUnselected,
    AppIcons.favoriteUnselected,
    AppIcons.userUnselected,
  ];

  List<String> selectedIcon = [
    AppIcons.homeSelected,
    AppIcons.profileSelected,
    AppIcons.calendarSelected,
    AppIcons.favoriteSelected,
    AppIcons.userSelected,
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navBarBackgroundColor,
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 30.w, vertical: 7.h),
      alignment: Alignment.center,
      // color: AppColors.greenNormalGreen4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
              (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(2),
              child: Container(
                decoration: BoxDecoration(
                    color: index == bottomNavIndex ? AppColors.fromRgb : null,
                    borderRadius: BorderRadius.circular(30)),
                child: index == bottomNavIndex
                    ? SvgPicture.asset(
                  selectedIcon[index],
                  height: 24.w,
                  width: 24.h,
                )
                    : SvgPicture.asset(
                  unselectedIcon[index],
                  height: 24.w,
                  width: 24.h,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAll(() => HomeScreen());
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.to(() => const FollowingScreen());
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.to(() =>  const CalenderScreen());
      }
    }
    //
    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.to(() => const FavoriteScreen());
      }
    }else if (index == 4) {
      if (!(widget.currentIndex == 4)) {
        Get.to(() => const ProfileScreen());
      }
    }
  }
}