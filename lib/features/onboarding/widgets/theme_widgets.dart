import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_styles.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Theme".tr(), style:isDark?AppStyles.medium20white: AppStyles.bold18mainColor.copyWith(fontSize: 20)),

        Row(
          children: [
            /// Light Theme Button
            ElevatedButton(
              onPressed: () {
                themeProvider.changeTheme(ThemeMode.light);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                !isDark ? AppColors.lightPrimary : AppColors.darkInput,
                elevation: 0,
              ),
              child: Image.asset(
                !isDark
                    ? AppAssets.sunIcon
                    : AppAssets.darkSunIcon,
              ),
            ),

            const Gap(6),

            ///  Dark Theme Button
            ElevatedButton(
              onPressed: () {
                themeProvider.changeTheme(ThemeMode.dark);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isDark ? AppColors.darkPrimary : AppColors.lightInput,
                elevation: 0,
              ),
              child: Image.asset(
                isDark
                    ? AppAssets.darkMoonIcon
                    : AppAssets.moonIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
