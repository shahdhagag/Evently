import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_styles.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Language",style: AppStyles.bold18mainColor),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightPrimary,
                ),
                child: const Text(
                  "English",
                  style: TextStyle(
                    color: AppColors.lightInput,
                    fontSize: 14,
                  ),
                ),
              ), Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightInput,
                ),
                child: const Text(
                  "Arabic",
                  style: TextStyle(
                    color: AppColors.lightPrimary,
                    fontSize: 14,
                  ),
                ),
              )

            ]
        )

      ],
    );
  }
}
