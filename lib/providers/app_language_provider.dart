import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale _appLanguage = const Locale('en', 'US'); // default

  Locale get appLanguage => _appLanguage;

  void changeLanguage(Locale newLocale, BuildContext context) {
    if (_appLanguage == newLocale) return;

    _appLanguage = newLocale;
    notifyListeners();

    // Update easy_localization
    context.setLocale(newLocale);
  }
}
