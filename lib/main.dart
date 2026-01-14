import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/app_theme.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      startLocale: Locale('ar', 'EG'),

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
    var appProvider=Provider.of<AppLanguageProvider>(context);

    return MaterialApp.router(
      routerConfig: AppRouts.router,
      debugShowCheckedModeBanner: false,
      title: 'Evently',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: appProvider.appLanguage,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
