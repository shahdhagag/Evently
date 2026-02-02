import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupTextSpan extends StatelessWidget {
  const SignupTextSpan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don’t have an account?".tr(),
          style: Theme.of(context).textTheme.bodySmall,
          children: [
            TextSpan(
              text: "Signup".tr(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.go(AppRouts.registerScreen);
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
                },
            ),
          ],
        ),
      ),
    );
  }
}
