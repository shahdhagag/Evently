import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'providers/app_language_provider.dart';
import 'core/utiles/app_route.dart';
import 'core/utiles/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('ar', 'EG'),

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
          ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the provider to get current language
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);

    return MaterialApp.router(
      routerConfig: AppRouts.router,
      debugShowCheckedModeBanner: false,
      title: 'Evently',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: languageProvider.appLanguage, // Use provider's current language
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,// Use provider's current theme
    );
  }
}
