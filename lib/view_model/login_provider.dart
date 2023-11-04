import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  // Validasi Email
  String? validateEmail(email) {
    if (email.isEmpty) {
      return "Email tidak boleh kosong";
    } else if (email.contains(RegExp(r'[!#<>?":$_`~;[\]\\|=+)(*&^%-]'))) {
      return 'Email tidak boleh mengandung karakter khusus!';
    } else {
      return null;
    }
  }

  // Validasi Pass
  String? validatePass(pass) {
    if (pass.isEmpty) {
      return "Password tidak boleh kosong!";
    } else if (pass.split('').length < 8) {
      return 'Password harus terdiri dari minimal 8 kata!';
    } else {
      return null;
    }
  }

  // Show Password
  void toggleObscureText() {
    notifyListeners();
    _obscureText = !_obscureText;
  }
}
