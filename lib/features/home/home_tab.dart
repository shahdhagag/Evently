// -------------------- HomeTab --------------------
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/app_theme.dart';
import 'package:evently/features/home/widgets/event_item.dart';
import 'package:evently/features/home/widgets/tab_category_widget.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<EventListProvider>();
  //  provider.getEventsStream(); // live updates for all tabs

    _tabController = TabController(
      length: provider.eventsNameList.length,
      vsync: this,
      initialIndex: provider.selectedIndex,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        provider.changeCategory(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    final languageProvider = context.watch<AppLanguageProvider>();
    final currentUser = FirebaseAuth.instance.currentUser;
    final userName = currentUser?.displayName ?? "User";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        title: WelcomeUserWidget(themeProvider: themeProvider, userName: userName),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              themeProvider.changeTheme(
                themeProvider.isDarkMode() ? ThemeMode.light : ThemeMode.dark,
              );
            },
            child: Image.asset(
              themeProvider.isDarkMode() ? 'assets/images/moon.png' : 'assets/images/sunIcon.png',
              width: 32.w,
              height: 32.h,
            ),
          ),
          SizedBox(width: 12.w),
          ENorArButton(languageProvider: languageProvider, themeProvider: themeProvider),
          SizedBox(width: 12.w),
        ],
      ),
      body: Consumer<EventListProvider>(
        builder: (context, provider, child) {
          final isDark = themeProvider.isDarkMode();
          final eventNamesList = provider.eventsNameList;

          return Column(
            children: [
              Container(
                height: 90.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Directionality(
                  textDirection: context.locale.languageCode == 'ar'
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.black,
                    tabAlignment: TabAlignment.start,
                    tabs: eventNamesList.map((eventName) {
                      final index = eventNamesList.indexOf(eventName);
                      return TabCategoryWidget(
                        eventName: eventName,
                        isSelected: provider.selectedIndex == index,
                        selectedColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                        selectedTextStyle:
                        (isDark ? AppTheme.darkTheme.textTheme.labelMedium : AppTheme.lightTheme.textTheme.labelMedium)
                            ?.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        unselectedBorderColor: isDark ? AppColors.darkStroke : AppColors.lightStroke,
                        unselectedColor: isDark ? AppColors.darkBackground : Colors.white,
                        unselectedTextStyle:
                        (isDark ? AppTheme.darkTheme.textTheme.labelMedium : AppTheme.lightTheme.textTheme.labelMedium)
                            ?.copyWith(
                          color: isDark ? AppColors.darkMainText : AppColors.lightMainText,
                          fontSize: 14.sp,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: provider.isLoading
                    ? Center(
                  child: CircularProgressIndicator(
                    color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                  ),
                )
                    : provider.eventsList.isEmpty
                    ? Center(child: NoEventsYetWidget(themeProvider: themeProvider))
                    : ListView.separated(
                  itemCount: provider.eventsList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return EventItem(event: provider.eventsList[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NoEventsYetWidget extends StatelessWidget {
  const NoEventsYetWidget({super.key, required this.themeProvider});
  final AppThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.event_busy, size: 60.sp, color: themeProvider.isDarkMode() ? AppColors.darkDisabled : AppColors.lightDisabled),
        SizedBox(height: 12.h),
        Text(
          'No Events Yet'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: themeProvider.isDarkMode() ? AppColors.darkMainText : AppColors.lightMainText,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Tap + to add your first event'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.sp,
            color: themeProvider.isDarkMode() ? AppColors.darkSecText : AppColors.lightSecText,
          ),
        ),
        SizedBox(height: 12.h),
        ElevatedButton(
          onPressed: () {
            context.go(AppRouts.addEventScreen);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: themeProvider.isDarkMode() ? AppColors.darkPrimary : AppColors.lightPrimary,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
          child: Text(
            '+ Add Event'.tr(),
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class WelcomeUserWidget extends StatelessWidget {
  const WelcomeUserWidget({super.key, required this.themeProvider, required this.userName});
  final AppThemeProvider themeProvider;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back ✨".tr(),
          style: themeProvider.isDarkMode()
              ? AppTheme.darkTheme.textTheme.bodySmall
              : AppTheme.lightTheme.textTheme.bodySmall,
        ),
        SizedBox(height: 4.h),
        Text(
          userName,
          style: themeProvider.isDarkMode()
              ? AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(color: Colors.white)
              : AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}

class ENorArButton extends StatelessWidget {
  const ENorArButton({super.key, required this.languageProvider, required this.themeProvider});
  final AppLanguageProvider languageProvider;
  final AppThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final newLocale = context.locale.languageCode == 'en'
            ? const Locale('ar', 'EG')
            : const Locale('en', 'US');

        // Change provider language
        languageProvider.changeLanguage(newLocale, context);

        // Update EasyLocalization locale
        await context.setLocale(newLocale);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: themeProvider.isDarkMode() ? AppColors.darkPrimary : AppColors.lightPrimary,
        minimumSize: Size(34.w, 34.h),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(
        languageProvider.appLanguage.languageCode == 'ar' ? "AR" : "EN",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
      ),
    );
  }
}

