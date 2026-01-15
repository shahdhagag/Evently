import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'providers/app_language_provider.dart';
import 'features/home/home_screen.dart';
import 'core/utiles/app_route.dart';
import 'core/utiles/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations', // path to your JSON translation files
      fallbackLocale: const Locale('en', 'US'), // default if translation missing
      startLocale: const Locale('ar', 'EG'), // starting language

      child: ChangeNotifierProvider(
        create: (context) => AppLanguageProvider(),
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
    var appProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp.router(
      routerConfig: AppRouts.router,
      debugShowCheckedModeBanner: false,
      title: 'Evently',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: appProvider.appLanguage, // Use provider's current language
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
