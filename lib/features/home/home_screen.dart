import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider=Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("hallow".tr()),
      ),
    );
  }
}
