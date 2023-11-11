import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/keys.dart';

class LoginProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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

  authenticateLogin() async {
    // ignore: unused_local_variable
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text,);
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.red,
      ));
    }
  }
}
