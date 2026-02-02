import 'package:evently/core/utiles/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabCategoryWidget extends StatelessWidget {
  bool isSelected;
  Color selectedColor;
  Color unselectedColor;
  Color unselectedBorderColor;
  String eventName;
TextStyle? selectedTextStyle;
TextStyle ?unselectedTextStyle;
   TabCategoryWidget({super.key, required this.isSelected, required this.selectedColor, required this.unselectedColor, required this.unselectedBorderColor, required this.eventName, required this.selectedTextStyle, required this.unselectedTextStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(
        horizontal: context.w(18),
        vertical:context.h(12),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isSelected ? selectedColor : unselectedColor,
      border:   Border.all(
        color: isSelected? Colors.transparent : unselectedBorderColor,
        width: 1,
      )
      ),
      child: Text(eventName,style:isSelected?selectedTextStyle:unselectedTextStyle,

      ),
    );
  }
}
