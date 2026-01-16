import 'package:evently/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightInput,
        foregroundColor: AppColors.lightPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkInput,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
    ),
  );
}
