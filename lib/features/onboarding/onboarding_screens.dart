import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/shared/custom_button.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/extentions.dart';
import 'package:evently/core/utiles/first_launch.dart';
import 'package:evently/features/onboarding/widgets/arrow_back_widget.dart';
import 'package:evently/features/onboarding/widgets/expanding_dots.dart';
import 'package:evently/features/onboarding/widgets/skip_button.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
    _pageController.animateToPage(
      _currentPage + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Top Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.w(16),
                vertical: context.h(8),
              ),
              child: OnBoardingTopBar(themeProvider),
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
                    padding: EdgeInsets.all(context.w(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Image
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Image.asset(
                              themeProvider.isDarkMode()
                                  ? page['dark_image']!
                                  : page['image']!,
                            ),
                          ),
                        ),

                        SizedBox(height: context.h(25)),

                        /// Dots
                        ExpandingDots(
                          pageController: _pageController,
                          pages: _pages,
                        ),

                        Gap(context.h(16)),

                        /// Title
                        Text(
                          page['title']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.isDarkMode()
                                ? AppColors.darkMainText
                                : AppColors.lightMainText,
                          ),
                        ),

                        Gap(context.h(8)),

                        /// Subtitle
                        Text(
                          page['subtitle']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: themeProvider.isDarkMode()
                                ? AppColors.darkSecText
                                : AppColors.lightSecText,
                          ),
                        ),

                        Gap(context.h(16)),

                        /// Button
                        CustomButton(
                          title: page['button']!,
                          onTap: () async {
                            if (_currentPage == _pages.length - 1) {
                              await FirstLaunch.completeOnboarding();  // onboarding  done
                              context.go(AppRouts.loginScreen);
                            } else {
                              _nextPage();
                            }
                          },
                        ),
                        SizedBox(height: context.h(10)),
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

  Row OnBoardingTopBar(AppThemeProvider themeProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _currentPage == 0
            ? const SizedBox()
            : GestureDetector(
          onTap: _previousPage,
          child: const ArrowBackWidget(),
        ),
        Center(
          child: Image.asset(
            themeProvider.isDarkMode()
                ? AppAssets.darkEvenlyLogo
                : AppAssets.evenlyLogo,
            width: context.w(145),
          ),
        ),
        const SkipButton(),
      ],
    );
  }
}
