import 'package:evently/features/onboarding/onborading1.dart';
import 'package:evently/features/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouts {
  static const splashScreen = "/";
  static const onboardingScreen = "/onboarding_Screen";

  static final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [

      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),


    ],
  );
}

