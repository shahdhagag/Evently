import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:evently/core/firebase_functions/firebase_functions.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Password visibility
  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  void toggleConfirmVisibility() {
    isConfirmHidden = !isConfirmHidden;
    notifyListeners();
  }

  // Validators
  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required'.tr();
    if (value.trim().length < 2) return 'Enter a valid name'.tr();
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email is required'.tr();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email'.tr();
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password is required'.tr();
    if (value.length < 6) return 'Password must be at least 6 characters'.tr();
    return null;
  }

  String? confirmValidator(String? value) {
    if (value == null || value.isEmpty) return 'Confirm your password'.tr();
    if (value != passwordController.text) return 'Passwords do not match'.tr();
    return null;
  }

///  Register function
  Future<bool> register() async {
    _errorMessage = null;

    // 1. Validate the form fields
    if (!formKey.currentState!.validate()) return false;

    _isLoading = true;
    notifyListeners();

    try {
      // 2. Call Firebase registration
      await FirebaseFunctions.createUser(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
      );

      _isLoading = false;
      notifyListeners();
      return true; // Return true so the UI knows to navigate
    } catch (e) {
      _errorMessage = 'Registration failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false; // Return false so the UI stays on the page
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmController.clear();
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}
