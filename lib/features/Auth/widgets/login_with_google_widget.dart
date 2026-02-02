import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/firebase_functions/firebase_functions.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginGoogleWidget extends StatelessWidget {
  const LoginGoogleWidget({
    super.key,
    required this.themeProvider,
  });

  final AppThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive sizes
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return SizedBox(
      width: double.infinity,
      height: height * 0.065, // responsive button height
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
            debugPrint('Google Sign-In failed: $e');
          }
        },
        icon: Image.asset(
          AppAssets.googleLogo,
          width: width * 0.06, // responsive icon size
          height: width * 0.06,
        ),
        label: Text(
          'Login with Google'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: width * 0.045, // responsive font size
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: themeProvider.isDarkMode()
                ? AppColors.darkStroke
                : AppColors.lightStroke,
            width: 1.5,
          ),
          padding: EdgeInsets.symmetric(
            vertical: height * 0.015, // responsive vertical padding
            horizontal: width * 0.04, // responsive horizontal padding
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.04), // responsive radius
          ),
          backgroundColor: themeProvider.isDarkMode()
              ? AppColors.darkInput
              : AppColors.lightInput,
        ),
      ),
    );
  }
}
