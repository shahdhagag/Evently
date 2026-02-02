import 'package:evently/core/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvenImageWidget extends StatelessWidget {
  const EvenImageWidget({
    super.key,
    required this.isDark,
    required this.selectedEventImage,
  });

  final bool isDark;
  final String selectedEventImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color:
          isDark ? AppColors.darkStroke : AppColors.lightStroke,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.asset(selectedEventImage, fit: BoxFit.cover),
      ),
    );
  }
}
