import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/extentions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(AppRouts.onboardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                AppAssets.evenlyLogo,
                width: context.w(300),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: context.h(50),
            ),
            child: Image.asset(
              AppAssets.routeLogo,
              width: context.w(70),
            ),
          ),
        ],
      ),
    );
  }
}
