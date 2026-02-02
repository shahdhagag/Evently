import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  // Password visibility
  bool isPasswordHidden = true;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  // Validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // Login function
  Future<void> login() async {
    _errorMessage = null;

    if (!formKey.currentState!.validate()) return;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    _errorMessage = null;
    _successMessage = null;
    _isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _successMessage = 'Password reset link sent to $email';
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Failed to send reset email';
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verify email
  Future<void> verifyEmail() async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        _successMessage = 'Verification email sent to ${user.email}';
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Failed to send verification email';
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
