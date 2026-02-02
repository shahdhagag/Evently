import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/firebase_functions/firebase_functions.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpGoogleWidget extends StatelessWidget {
  const SignUpGoogleWidget({
    super.key,
    required this.themeProvider,
  });

  final AppThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          try {
            // 1. Wait for the login to finish
            var user = await FirebaseFunctions.signInWithGoogle();

            // 2. If login was successful, go to Home
            if (user != null && context.mounted) {
              context.go(AppRouts.homeScreen);
            }
          } catch (e) {
            debugPrint('Google Sign-Up failed: $e');
          }
        },

        icon: Image.asset(
          AppAssets.googleLogo,
          width: 24,
        ),
        label: Text(
          'Sign up with Google'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: themeProvider.isDarkMode()
                ? AppColors.darkStroke
                : AppColors.lightStroke,
          ),
          padding: const EdgeInsets.symmetric(vertical: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: themeProvider.isDarkMode()
              ? AppColors.darkInput
              : AppColors.lightInput,
        ),
      ),
    );
  }
}
