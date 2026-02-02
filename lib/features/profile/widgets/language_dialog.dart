import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({
    super.key,
    required this.languageProvider,
  });

  final AppLanguageProvider languageProvider;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding:  EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'choose_language'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
             SizedBox(height: 16.h),
            ListTile(
              title: Text('English'.tr()),
              trailing: languageProvider.appLanguage.languageCode == 'en'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                languageProvider.changeLanguage(const Locale('en', 'US'), context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Arabic'.tr()),
              trailing: languageProvider.appLanguage.languageCode == 'ar'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                languageProvider.changeLanguage(const Locale('ar', 'EG'), context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
