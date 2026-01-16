
import 'package:evently/core/utiles/app_colors.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExpandingDots extends StatelessWidget {
  const ExpandingDots({
    super.key,
    required PageController pageController,
    required List<Map<String, String>> pages,
  }) : _pageController = pageController,
        _pages = pages;

  final PageController _pageController;
  final List<Map<String, String>> _pages;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    return Center(
      child: SmoothPageIndicator(
        controller: _pageController,
        count: _pages.length,
        effect: ExpandingDotsEffect(
          activeDotColor:themeProvider.isDarkMode()?AppColors.darkPrimary: AppColors.lightPrimary,
          dotColor: themeProvider.isDarkMode()?AppColors.lightBackground: AppColors.lightDisabled,
          dotHeight: 8,
          dotWidth: 8,
          spacing: 6,
          expansionFactor: 2.5,
        ),
        onDotClicked: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
