import 'package:flutter/material.dart';

extension MediaQuerySize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double w(double value) => screenWidth * (value / 375);
  double h(double value) => screenHeight * (value / 812);
}
