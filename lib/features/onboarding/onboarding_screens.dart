import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/shared/custom_button.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/features/onboarding/widgets/arrow_back_widget.dart';
import 'package:evently/features/onboarding/widgets/expanding_dots.dart';
import 'package:evently/features/onboarding/widgets/skip_button.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/light_onboard1.png',
      'dark_image': 'assets/images/dark_onboard1.png',
      'title': 'onboardTitle1'.tr(),
      'subtitle': 'onboardSubTitle1'.tr(),
      'button': 'onboardButton1'.tr(),
    },
    {
      'image': 'assets/images/light_onboad2.png',
      'dark_image': 'assets/images/dark_onboard2.png',
      'title': 'onboardTitle2'.tr(),
      'subtitle': 'onboardSubTitle2'.tr(),
      'button': 'onboardButton2'.tr(),
    },
    {
      'image': 'assets/images/light_onboard3.png',
      'dark_image': 'assets/images/dark_onboard3.png',
      'title': 'onboardTitle3'.tr(),
      'subtitle': 'onboardSubTitle3'.tr(),
      'button': 'onboardButton3'.tr(),
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    ThemeMode currentTheme = themeProvider.appTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Top Bar header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage == 0)
                    SizedBox()
                  else
                    GestureDetector(onTap: _previousPage, child: ArrowBackWidget()),
                  Center(child: Image.asset(themeProvider.isDarkMode()?AppAssets.darkEvenlyLogo:AppAssets.evenlyLogo, width: 145)),
                  SkipButton(),
                ],
              ),
            ),

            /// PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// images
                        Expanded(
                          flex: 3,
                          child: Center(child: Image.asset(themeProvider.isDarkMode()?page['dark_image']! :page['image']!)),
                        ),
                        const SizedBox(height: 25),

                        /// expandable dots
                        ExpandingDots(
                          pageController: _pageController,
                          pages: _pages,
                        ),
                        const Gap(16),

                        /// title and subtitle
                        Text(
                          page['title']!,
                          style:  TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:themeProvider.isDarkMode()?AppColors.darkMainText: AppColors.lightMainText,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          page['subtitle']!,
                          style:  TextStyle(
                            fontSize: 14,
                            color:themeProvider.isDarkMode()?AppColors.darkSecText: AppColors.lightSecText,
                          ),
                        ),
                        const Gap(16),

                        /// button
                        CustomButton(title: page['button']!, onTap: _nextPage),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
