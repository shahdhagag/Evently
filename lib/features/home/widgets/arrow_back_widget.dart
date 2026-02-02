import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ArrowBackIconWidget extends StatelessWidget {
  const ArrowBackIconWidget({
    super.key,
    required this.isDark,
    required this.isEditMode,
  });

  final bool isDark;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isDark ? AppColors.darkInput : Colors.white,
          border: Border.all(
            color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
          ),
        ),
        child: Image.asset(
          AppAssets.arrowIcon,
          color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
          width: 24.w,
          height: 24.w,
        ),
      ),
      onPressed: () {
        isEditMode ? context.pop() : context.go(AppRouts.homeScreen);
      },
    );
  }
}