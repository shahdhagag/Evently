import 'package:easy_localization/easy_localization.dart';
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Language".tr(), style: AppStyles.bold18mainColor),
        Row(
          children: [
            // English button
            GestureDetector(
              onTap: () =>
                  provider.changeLanguage(const Locale('en', 'US'), context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: current.languageCode == 'en'
                      ? AppColors.lightPrimary
                      : AppColors.lightInput,
                ),
                child: Text(
                  "English".tr(),
                  style: TextStyle(
                    color: current.languageCode == 'en'
                        ? AppColors.lightInput
                        : AppColors.lightPrimary,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Arabic button
            GestureDetector(
              onTap: () =>
                  provider.changeLanguage(const Locale('ar', 'EG'), context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: current.languageCode == 'ar'
                      ? AppColors.lightPrimary
                      : AppColors.lightInput,
                ),
                child: Text(
                  "Arabic".tr(),
                  style: TextStyle(
                    color: current.languageCode == 'ar'
                        ? AppColors.lightInput
                        : AppColors.lightPrimary,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
