import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Function(String)? onChanged;


  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    final isDark = themeProvider.isDarkMode();

    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return TextField(
      controller: controller,
      onChanged:onChanged ,
      style: TextStyle(
        fontSize: width * 0.04,
        color: isDark ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: width * 0.035,
          color: isDark ? AppColors.darkSecText : AppColors.lightSecText,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkInput : Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.012,
        ),
        suffixIcon: Image.asset(
          AppAssets.searchIcon,
          width: width * 0.065,
          height: width * 0.065,
          color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkStroke : AppColors.lightStroke,
            width: 1,
          ),
        ),
      ),
    );
  }
}
