import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/first_launch.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    ThemeMode currentTheme = themeProvider.appTheme;
    return TextButton(
      onPressed: () async{
        await FirstLaunch.completeOnboarding();

        context.go(AppRouts.loginScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: themeProvider.isDarkMode()
            ? BoxDecoration(
                color: AppColors.darkInput,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.darkStroke, width: 1),
              )
            : BoxDecoration(
                color: AppColors.lightInput,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.lightStroke, width: 1),
              ),
        child: Text(
          'Skip'.tr(),
          style: TextStyle(
            color: themeProvider.isDarkMode()
                ? AppColors.lightInput
                : AppColors.lightPrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
