
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    ThemeMode currentTheme = themeProvider.appTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration:themeProvider.isDarkMode()? BoxDecoration(
        color: AppColors.darkInput,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkStroke, width: 1),
      ):BoxDecoration(
        color: AppColors.lightInput,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightStroke, width: 1),
      ),
      child: InkWell(
        child:  Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          color: themeProvider.isDarkMode()?AppColors.lightInput:AppColors.lightPrimary,
        ),
      ),
    );
  }
}
