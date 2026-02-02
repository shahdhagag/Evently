import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppDialogs {
  /// Show a success SnackBar
  static void showSuccessSnackBar(BuildContext context, String message) {
    final themeProvider = context.read<AppThemeProvider>();
    final isDark = themeProvider.isDarkMode();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 24.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show an error SnackBar
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white, size: 24.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show date picker
  static Future<DateTime?> pickDate(BuildContext context, DateTime? initialDate) async {
    final themeProvider = context.read<AppThemeProvider>();
    final isDark = themeProvider.isDarkMode();

    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: context.locale,
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme(
            brightness: isDark ? Brightness.dark : Brightness.light,
            primary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
            onPrimary: Colors.white,
            secondary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
            onSecondary: Colors.white,
            surface: isDark ? AppColors.darkInput : Colors.white,
            onSurface: isDark ? AppColors.darkMainText : AppColors.lightMainText,
            background: isDark ? AppColors.darkBackground : AppColors.lightBackground,
            error: AppColors.red,
            onError: Colors.white,
          ),
          dialogBackgroundColor: isDark ? AppColors.darkBackground : Colors.white,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              textStyle: TextStyle(fontSize: 14.sp),
            ),
          ),
        ),
        child: child!,
      ),
    );
  }

  /// Show time picker
  static Future<TimeOfDay?> pickTime(BuildContext context, TimeOfDay? initialTime) async {
    final themeProvider = context.read<AppThemeProvider>();
    final isDark = themeProvider.isDarkMode();

    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme(
            brightness: isDark ? Brightness.dark : Brightness.light,
            primary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
            onPrimary: Colors.white,
            secondary: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
            onSecondary: Colors.white,
            surface: isDark ? AppColors.darkInput : Colors.white,
            onSurface: isDark ? AppColors.darkMainText : AppColors.lightMainText,
            background: isDark ? AppColors.darkBackground : AppColors.lightBackground,
            error: AppColors.red,
            onError: Colors.white,
          ),
          dialogBackgroundColor: isDark ? AppColors.darkBackground : Colors.white,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              textStyle: TextStyle(fontSize: 14.sp),
            ),
          ),
        ),
        child: child!,
      ),
    );
  }
}
