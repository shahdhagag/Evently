import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/shared/custom_button.dart';
import 'package:evently/core/shared/custom_divider.dart';
import 'package:evently/core/shared/custom_text_form_field.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/core/utiles/extentions.dart';
import 'package:evently/features/Auth/widgets/custom_text_span.dart';
import 'package:evently/features/Auth/widgets/sign_up_withGoogle_widget.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            themeProvider.isDarkMode()
                ? AppAssets.darkEvenlyLogo
                : AppAssets.evenlyLogo,
            width: context.w(145),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w(17),
          ),
          child: Consumer<RegisterProvider>(
            builder: (context, registerProvider, _) {
              return Form(
                key: registerProvider.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(context.h(24)),
                      Text(
                        "Create your account".tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Gap(context.h(24)),
                      CustomTextFormField(
                        hint: 'Enter your name'.tr(),
                        icon: Image.asset(AppAssets.userLogo),
                        keyboardType: TextInputType.name,
                        controller: registerProvider.nameController,
                        validator: registerProvider.nameValidator,
                      ),
                      Gap(context.h(16)),
                      CustomTextFormField(
                        hint: 'Enter your email'.tr(),
                        icon: Image.asset(AppAssets.emailIcon),
                        keyboardType: TextInputType.emailAddress,
                        controller: registerProvider.emailController,
                        validator: registerProvider.emailValidator,
                      ),
                      Gap(context.h(16)),
                      CustomTextFormField(
                        hint: 'Enter your password'.tr(),
                        icon: Image.asset(AppAssets.lockIcon),
                        isPassword: true,
                        obscureText: registerProvider.isPasswordHidden,
                        onTogglePassword: registerProvider.togglePasswordVisibility,
                        controller: registerProvider.passwordController,
                        validator: registerProvider.passwordValidator,
                      ),
                      Gap(context.h(16)),
                      CustomTextFormField(
                        hint: 'Confirm your password'.tr(),
                        icon: Image.asset(AppAssets.lockIcon),
                        isPassword: true,
                        obscureText: registerProvider.isConfirmHidden,
                        onTogglePassword: registerProvider.toggleConfirmVisibility,
                        controller: registerProvider.confirmController,
                        validator: registerProvider.confirmValidator,
                      ),
                      if (registerProvider.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(
                            top: context.h(16),
                          ),
                          child: Text(
                            registerProvider.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Gap(context.h(20)),
                      CustomButton(
                        title: registerProvider.isLoading ? 'Loading...'.tr() : 'Sign up'.tr(),
                        onTap: () async {
                          if (!registerProvider.isLoading) {
                            bool success = await registerProvider.register();

                            if (success && context.mounted) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Account created! Please check your email to verify before logging in.".tr()),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 5),
                                ),
                              );


                              context.go(AppRouts.loginScreen);
                            }
                          }
                        },
                      ),
                      Gap(context.h(20)),
                      const CustomTextSpan(),
                      Gap(context.h(10)),
                      CustomDivider(themeProvider: themeProvider),
                      Gap(context.h(10)),
                      SignUpGoogleWidget(themeProvider: themeProvider),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
