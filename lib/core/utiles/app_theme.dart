import 'package:evently/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.lightBackground,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightInput,
        foregroundColor: AppColors.lightPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.lightPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(color: AppColors.lightSecText, fontSize: 14),
      bodyMedium: TextStyle(color: AppColors.lightInput, fontSize: 20),

      titleSmall: TextStyle(color: AppColors.lightPrimary, fontSize: 14),
      titleMedium: TextStyle(color: AppColors.lightPrimary, fontSize: 18),
      labelMedium: TextStyle(color: AppColors.lightMainText, fontSize: 16),
      labelLarge: TextStyle(
        color: AppColors.lightPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: 0,
        decoration: TextDecoration.underline,
        decorationColor:  AppColors.lightPrimary,
        decorationStyle: TextDecorationStyle.solid,
        color: AppColors.lightPrimary,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary, // or AppColors.primary
      foregroundColor: Colors.white,
      elevation: 6,
      shape: CircleBorder(),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(

      backgroundColor: Colors.white,
      selectedItemColor: AppColors.lightPrimary, // AppColors.primary
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
      type: BottomNavigationBarType.fixed,
      elevation:0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.darkBackground,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkInput,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.darkMainText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(color: AppColors.darkSecText, fontSize: 14),
      bodyMedium: TextStyle(color: AppColors.darkInput, fontSize: 20),

      titleSmall: TextStyle(color: AppColors.darkPrimary, fontSize: 14),
      titleMedium: TextStyle(color: AppColors.darkPrimary, fontSize: 18),
      labelMedium: TextStyle(color: AppColors.darkMainText, fontSize: 16),
      labelLarge: TextStyle(
        color: AppColors.darkPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: 0,
        decoration: TextDecoration.underline,
        decorationColor:  AppColors.darkPrimary,
        decorationStyle: TextDecorationStyle.solid,
        color: AppColors.darkPrimary,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.black,
      elevation: 6,
      shape: CircleBorder(),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.darkPrimary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
}
