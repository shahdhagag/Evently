import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/shared/custom_button.dart';
import 'package:evently/core/shared/custom_text_form_field.dart';
import 'package:evently/core/utiles/app_assets.dart';
import 'package:evently/core/utiles/app_route.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email is required'.tr();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email'.tr();
    return null;
  }

  Future<void> sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      setState(() {
        _successMessage = 'Reset link sent! Check your email.'.tr();
      });
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found with this email'.tr();
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address'.tr();
      } else {
        message = 'Error: ${e.message}';
      }
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong'.tr();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkMode();

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          isDark ? AppAssets.darkEvenlyLogo : AppAssets.evenlyLogo,
          width: width * 0.4,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                Text(
                  "Reset Your Password".tr(),
                  style: TextStyle(
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  "Enter your email address and we'll send you a link to reset your password"
                      .tr(),
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.03),
                CustomTextFormField(
                  hint: 'Enter your email'.tr(),
                  icon: Image.asset(AppAssets.emailIcon, width: width * 0.06, height: width * 0.06),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: emailValidator,
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                if (_successMessage != null)
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: Text(
                      _successMessage!,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                SizedBox(height: height * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.065,
                  child: CustomButton(
                    title: _isLoading ? 'Loading...'.tr() : 'Send Reset Link'.tr(),
                    onTap: _isLoading ? null : sendResetEmail,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: TextButton(
                    onPressed: () => context.go(AppRouts.loginScreen),
                    child: Text(
                      "Back to Login".tr(),
                      style: TextStyle(
                        fontSize: width * 0.045,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
