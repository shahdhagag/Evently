import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final Widget? icon;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final VoidCallback? onTogglePassword;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hint,
    this.icon,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onTogglePassword,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? obscureText : false,
      validator: validator,
      style: TextStyle(
        fontSize: 14.sp,
        color: themeProvider.isDarkMode()
            ? AppColors.darkDisabled
            : AppColors.lightDisabled,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: themeProvider.isDarkMode()
            ? AppColors.darkInput
            : AppColors.lightInput,
        prefixIcon: icon != null
            ? Padding(
          padding: EdgeInsets.all(12.w),
          child: icon,
        )
            : null,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: themeProvider.isDarkMode()
                ? AppColors.darkSecText
                : AppColors.lightSecText,
          ),
          onPressed: onTogglePassword,
        )
            : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        border: _border(),
        enabledBorder: _border(
          color: themeProvider.isDarkMode()
              ? AppColors.darkStroke
              : AppColors.lightStroke,
        ),
        focusedBorder: _border(
          color: themeProvider.isDarkMode()
              ? AppColors.darkStroke
              : AppColors.lightStroke,
        ),
      ),
    );
  }

  OutlineInputBorder _border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color ?? Colors.transparent),
    );
  }
}
