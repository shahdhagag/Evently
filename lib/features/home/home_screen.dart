import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/features/favourite/favourite_screen.dart';
import 'package:evently/features/home/home_tab.dart';
import 'package:evently/features/profile/profile_screen.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeTab(),
    FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkMode();

    final isRtl = context.locale.languageCode == 'ar';

    return Directionality(
      key: ValueKey(isRtl),
      textDirection: isRtl
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        body: screens[currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home-icon.png")),
              label: 'Home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/fav_icon.png")),
              label: 'Favourite'.tr(),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/profile_icon.png")),
              label: 'Profile'.tr(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go(AppRouts.addEventScreen);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
