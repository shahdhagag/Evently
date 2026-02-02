import 'package:evently/core/utiles/first_launch.dart';
import 'package:evently/core/utiles/go_router_refresh_stream.dart';
import 'package:evently/features/Auth/Login/login_screen.dart';
import 'package:evently/features/Auth/Register/register_screen.dart';
import 'package:evently/features/Auth/rest_pw_screen.dart';
import 'package:evently/features/home/add_event_screen.dart';
import 'package:evently/features/home/home_screen.dart';
import 'package:evently/features/onboarding/onboarding_screens.dart';
import 'package:evently/features/onboarding/onborading1.dart';
import 'package:evently/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRouts {
  static const splashScreen = "/";
  static const onboardingScreen = "/onboarding_Screen";
  static const onboardingScreens = "/onboarding_Screens";
  static const loginScreen = "/login_Screens";
  static const registerScreen = "/register_Screens";
  static const homeScreen = "/home_Screens";
  static const restPasswordScreen = "/restPassword_Screens";
  static const addEventScreen = "/AddEvent_Screens";

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),

    routes: [

      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state)async {
          final firstLaunch = await FirstLaunch.isFirstLaunch();
          final user = FirebaseAuth.instance.currentUser;
          if (firstLaunch) {
            return onboardingScreen;
          } else if (user != null) {
            return homeScreen;
          } else {
            return loginScreen;
          }
        },
      ),
      GoRoute(
        path: onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: onboardingScreens,
        builder: (context, state) => OnboardingScreens(),
      ),
      GoRoute(
        path: loginScreen,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: registerScreen,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: restPasswordScreen,
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        path: addEventScreen,
        builder: (context, state) => AddEventScreen(),
      ),
    ],
  );
}