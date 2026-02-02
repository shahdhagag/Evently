import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunch {
  static const _seenKey = 'seenOnboarding';

  // Check if this is the first launch
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool(_seenKey) ?? false;
    return !seen;
  }

  // Mark onboarding as completed
  static Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, true);
  }
}
