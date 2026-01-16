import 'package:evently/features/onboarding/onboarding_screens.dart';
import 'package:evently/features/onboarding/onborading1.dart';
import 'package:evently/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouts {
  static const splashScreen = "/";
  static const onboardingScreen = "/onboarding_Screen";
  static const onboardingScreens = "/onboarding_Screens";

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
      GoRoute(
        path: onboardingScreens,
        builder: (context, state) =>  OnboardingScreens(),
      ),


    ],
  );
}


