import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_theme.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsTile({super.key,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        width:343.w ,
        height:49.h ,
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode()?AppColors.darkInput:AppColors.lightInput,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: themeProvider.isDarkMode()?AppColors.darkStroke:AppColors.lightStroke,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(title, style:themeProvider.isDarkMode()?AppTheme.darkTheme.textTheme.labelMedium: AppTheme.lightTheme.textTheme.labelMedium),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
