import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.themeProvider,
  });

  final AppThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: themeProvider.isDarkMode()
                ? AppColors.darkStroke
                : AppColors.lightStroke,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            'Or'.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              color: themeProvider.isDarkMode()
                  ? AppColors.darkPrimary
                  : AppColors.lightPrimary,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: themeProvider.isDarkMode()
                ? AppColors.darkStroke
                : AppColors.lightStroke,
          ),
        ),
      ],
    );
  }
}
