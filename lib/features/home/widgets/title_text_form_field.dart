import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class title_text_form extends StatelessWidget {
  const title_text_form({
    super.key,
    required this.titleController,
    required this.isDark,
  });

  final TextEditingController titleController;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      cursorHeight: 20.h,
      style: TextStyle(
          fontSize: 14.sp,
          color: isDark ? Colors.white : Colors.black),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'please enter event title'.tr();
        }
        if (value.length < 3) {
          return 'Title must be at least 3 characters'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Event Title'.tr(),
        filled: true,
        fillColor: isDark ? AppColors.darkInput : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
