import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  //todo data + function to change this data
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
