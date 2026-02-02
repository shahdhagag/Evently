import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTextSpan extends StatelessWidget {
  const CustomTextSpan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Already have an account?".tr(),
          style: Theme.of(context).textTheme.bodySmall,
          children: [
            TextSpan(
              text: "Login".tr(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.go(AppRouts.loginScreen);
                },
            ),
          ],
        ),
      ),
    );
  }
}
