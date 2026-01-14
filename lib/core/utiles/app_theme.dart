import 'package:evently/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,


  );
  static final ThemeData darkTheme=ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
  );

}