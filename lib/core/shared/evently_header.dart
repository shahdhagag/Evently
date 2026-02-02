import 'package:evently/core/utiles/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventlyHeader extends StatelessWidget {
  const EventlyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Image.asset(
          AppAssets.evenlyLogo,
          width: 140.w,
        ),
      ),
    );
  }
}
