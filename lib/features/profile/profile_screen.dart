import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/firebase_functions/firebase_functions.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/features/profile/widgets/language_dialog.dart';
import 'package:evently/features/profile/widgets/settings_tile.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String userName = currentUser?.displayName ?? "User";
    final String userEmail = currentUser?.email ?? "example@email.com";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [

              ///  Profile Avatar
              CircleAvatar(
                radius: 44.r,
                backgroundColor: themeProvider.isDarkMode() ? AppColors.lightPrimary : AppColors.lightPrimary,
                child: Text(
                  "Evently",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              ///  User Name
              Text(
                userName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18.sp), // <- Responsive
              ),

              ///  Email
              Text(
                userEmail,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp), // <- Responsive
              ),

              SizedBox(height: 24.h),

              ///  Dark Mode switch
              SettingsTile(
                title: themeProvider.isDarkMode() ? "dark_mode".tr() : "light_mode".tr(),
                trailing: Switch(
                  activeColor: AppColors.darkPrimary,
                  inactiveThumbColor: Colors.grey[200],
                  value: themeProvider.isDarkMode(),
                  onChanged: (value) {
                    themeProvider.changeTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),

              Gap(12.h),

              ///  Language
              SettingsTile(
                title: context.watch<AppLanguageProvider>().appLanguage.languageCode == 'ar'
                    ? 'Arabic'.tr()
                    : 'English'.tr(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: themeProvider.isDarkMode() ? AppColors.darkPrimary : AppColors.lightPrimary,
                ),
                onTap: () {
                  final languageProvider = context.read<AppLanguageProvider>();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return LanguageDialog(languageProvider: languageProvider);
                    },
                  );
                },
              ),

              Gap(12.h),

              /// Logout
              SettingsTile(
                  title: "logout".tr(),
                  trailing: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  onTap: () async {
                    try {
                      //  RESET PROVIDER FIRST
                      context.read<EventListProvider>().reset();

                      //  Firebase logout
                      await FirebaseFunctions.logout();

                      // Go to login
                      context.go(AppRouts.loginScreen);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Logout failed")),
                      );
                    }
                  }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
