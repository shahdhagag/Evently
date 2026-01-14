import 'package:evently/core/utiles/app_assets.dart';
import 'package:flutter/material.dart';

class EventlyHeader extends StatelessWidget {
  const EventlyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Image.asset(
          AppAssets.evenlyLogo,
          width: 140,
        ),
      ),
    );
  }
}
