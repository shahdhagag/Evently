import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_styles.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppLanguageProvider>(context);
    Locale current = provider.appLanguage;

    final themeProvider = Provider.of<AppThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode();

    // Helper function to get colors based on selection & theme
    Color getBackgroundColor(String code) {
      if (current.languageCode == code) {
        return isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
      } else {
        return isDark ? AppColors.darkInput : AppColors.lightInput;
      }
    }

    Color getTextColor(String code) {
      if (current.languageCode == code) {
        return isDark ? AppColors.lightInput : AppColors.lightInput;
      } else {
        return isDark ? AppColors.lightInput : AppColors.lightPrimary;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Language".tr(),
          style: isDark
              ? AppStyles.medium20white
              : AppStyles.bold18mainColor.copyWith(fontSize: 20),
        ),

        Row(
          children: [
            /// English Button
            ElevatedButton(
              onPressed: () {
                provider.changeLanguage(const Locale('en', 'US'), context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: getBackgroundColor('en'),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "English".tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: getTextColor('en'),
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// Arabic Button
            ElevatedButton(
              onPressed: () {
                provider.changeLanguage(const Locale('ar', 'EG'), context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: getBackgroundColor('ar'),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Arabic".tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: getTextColor('ar'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
