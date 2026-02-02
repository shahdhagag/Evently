import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class desc_text_form extends StatelessWidget {
  const desc_text_form({
    super.key,
    required this.descController,
    required this.isDark,
  });

  final TextEditingController descController;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descController,
      minLines: 5,
      maxLines: 6,
      maxLength: 1000,
      cursorHeight: 20.h,
      style: TextStyle(
          fontSize: 14.sp,
          color: isDark ? Colors.white : Colors.black),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'please enter event Description'.tr();
        }
        if (value.length < 10) {
          return 'Description must be at least 10 characters'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Event Description....'.tr(),
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
