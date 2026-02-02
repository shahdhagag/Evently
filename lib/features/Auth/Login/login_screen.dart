import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/firebase_functions/firebase_functions.dart';
import 'package:evently/core/shared/custom_button.dart';
import 'package:evently/core/shared/custom_divider.dart';
import 'package:evently/core/shared/custom_text_form_field.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/extentions.dart';
import 'package:evently/features/Auth/widgets/login_with_google_widget.dart';
import 'package:evently/features/Auth/widgets/signupTextSpan.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // <-- added

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            themeProvider.isDarkMode()
                ? AppAssets.darkEvenlyLogo
                : AppAssets.evenlyLogo,
            width: 145.w, // responsive width
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w), // responsive padding
            child: Consumer<LoginProvider>(
              builder: (context, loginProvider, _) {
                return Form(
                  key: loginProvider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(24.h), // responsive gap
                      Text(
                        "Login to your account".tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Gap(24.h),
                      CustomTextFormField(
                        hint: 'Enter your email'.tr(),
                        icon: Image.asset(AppAssets.emailIcon),
                        keyboardType: TextInputType.emailAddress,
                        controller: loginProvider.emailController,
                        validator: loginProvider.emailValidator,
                      ),
                      Gap(16.h),
                      CustomTextFormField(
                        hint: 'Enter your password'.tr(),
                        icon: Image.asset(AppAssets.lockIcon),
                        isPassword: true,
                        obscureText: loginProvider.isPasswordHidden,
                        onTogglePassword: loginProvider.togglePasswordVisibility,
                        controller: loginProvider.passwordController,
                        validator: loginProvider.passwordValidator,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.go(AppRouts.restPasswordScreen);
                            },
                            child: Text(
                              "Forget Password?".tr(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                      if (loginProvider.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h), // responsive
                          child: Text(
                            loginProvider.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Gap(20.h),
                      CustomButton(
                        title: loginProvider.isLoading
                            ? 'loading'.tr()
                            : 'Login'.tr(),
                        onTap: loginProvider.isLoading
                            ? null
                            : () {
                          FirebaseFunctions.login(
                            loginProvider.emailController.text.trim(),
                            loginProvider.passwordController.text.trim(),
                                () {
                              loginProvider.clearForm();
                              context.go(AppRouts.homeScreen);
                            },
                                () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login failed'),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Gap(48.h),
                      const SignupTextSpan(),
                      Gap(24.h),
                      CustomDivider(themeProvider: themeProvider),
                      Gap(24.h),
                      LoginGoogleWidget(themeProvider: themeProvider),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
