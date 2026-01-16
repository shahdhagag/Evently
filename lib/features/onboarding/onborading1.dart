import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/shared/custom_button.dart';
import 'package:evently/core/shared/evently_header.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_styles.dart';
import 'package:evently/features/onboarding/widgets/language_widgets.dart';
import 'package:evently/features/onboarding/widgets/theme_widgets.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppLanguageProvider>(context);
    Locale current = provider.appLanguage;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    ThemeMode currentTheme = themeProvider.appTheme;


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            EventlyHeader(),
            Gap(24),
            Image.asset(
              currentTheme == ThemeMode.dark
                  ? AppAssets.onboardingCreativeDark
                  :
              AppAssets.onboardingCreative,
            ),
            Gap(24),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("onboardTitle".tr(), style:currentTheme == ThemeMode.dark?
                    AppStyles.bold20black.copyWith(color: Colors.white):
                    AppStyles.bold20black),
                Gap(8),
                Text("onboardSubTitle".tr(), style:currentTheme == ThemeMode.dark?
                AppStyles.normal16black.copyWith(color: Color(0XFFD6D6D6)):
            AppStyles.normal16black),


              ],
            ),
            Gap(16),
            LanguageWidget(),
            Gap(16),
            ThemeWidget(),
            Gap(21),
            CustomButton(
              title:  "Let's Start".tr(),
              onTap: () {

              },
            ),




          ],
        ),
      ),
    );
  }
}




