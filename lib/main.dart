import 'package:evently/firebase_options.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/search_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'providers/app_language_provider.dart';
import 'core/utiles/app_route.dart';
import 'core/utiles/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((_) {
    AppRouts.router.refresh();
  });

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
          ChangeNotifierProvider(create: (_) => EventListProvider()),
          //
          // ChangeNotifierProvider(
          //     create: (_) =>
          //     EventListProvider()..getEventsFromFirestore()..getEventsStream()),
          ChangeNotifierProvider(create: (_) => FavoriteSearchProvider()),
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
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812), // <-- your design's screen size (iPhone X is common)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouts.router,
          debugShowCheckedModeBanner: false,
          title: 'Evently',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: languageProvider.appLanguage,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.appTheme,
        );
      },
    );
  }
}
