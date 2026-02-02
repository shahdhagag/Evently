import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_styles.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        ),
        child: Center(
          child: Text(
            title,
            style: AppStyles.medium20white.copyWith(fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}
