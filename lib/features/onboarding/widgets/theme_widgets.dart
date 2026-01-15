import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_styles.dart';
import 'package:flutter/material.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Theme".tr(),style: AppStyles.bold18mainColor),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightPrimary,
                ),
                child: Image.asset(AppAssets.sunIcon),
              ),


              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightInput,
                ),
                child: Image.asset(AppAssets.moonIcon),

              )

            ]
        )

      ],
    );
  }
}
