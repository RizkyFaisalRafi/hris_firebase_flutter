import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_firebase_flutter/view/home_screen.dart';
import 'package:hris_firebase_flutter/view/register_screen.dart';
import 'package:hris_firebase_flutter/view_model/login_provider.dart';
import 'package:hris_firebase_flutter/widgets/button_custom.dart';
import 'package:hris_firebase_flutter/widgets/custom_form.dart';
import 'package:provider/provider.dart';

import '../common/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // final Function() onLogin;
  // final Function() onRegister;
  // const LoginScreen(
  //     {super.key, required this.onLogin, required this.onRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // mengakses data dari state
    final provider = Provider.of<LoginProvider>(context, listen: false);

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Login Screen"),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masuk',
                          style: GoogleFonts.roboto(
                              fontSize: 32,
                              fontWeight: medium,
                              color: const Color(0xFF00AFFF)),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Selamat Datang di Aplikasi HRIS, Untuk bisa masuk pastikan akun Anda sudah terdaftar.',
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Form(
                          key: provider.formKey,
                          child: Column(
                            children: [
                              // Email
                              CustomForm(
                                obscure: false,
                                controller: provider.emailController,
                                validate: provider.validateEmail,
                                title: 'Email',
                                typeForm: TextInputType.emailAddress,
                                isShow: false,
                                togleObscure: provider.toggleObscureText,
                              ),

                              const SizedBox(
                                height: 40,
                              ),

                              // Password
                              Consumer<LoginProvider>(
                                builder: (context, data, _) {
                                  return CustomForm(
                                    obscure: data.obscureText,
                                    controller: data.passwordController,
                                    validate: data.validatePass,
                                    title: 'Password',
                                    typeForm: TextInputType.visiblePassword,
                                    isShow: true,
                                    togleObscure: data.toggleObscureText,
                                  );
                                },
                              ),

                              // Forgot Pass
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Navigasi ke Forgot Pass Screen
                                    },
                                    child: Text(
                                      'Lupa Password?',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF00AFFF),
                                        fontSize: 12,
                                        fontWeight: bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 64,
                              ),

                              // MASUK BUTTON
                              ButtonCustom(
                                onTap: () async {
                                  if (provider.formKey.currentState!
                                      .validate()) {
                                    try {
                                      provider.authenticateLogin();
                                    } catch (e) {
                                      log('Error : $e');
                                    }
                                  }
                                },
                                label: 'Masuk',
                                isExpand: true,
                              ),

                              const SizedBox(
                                height: 16,
                              ),

                              ButtonCustom(
                                onTap: () {
                                  // Navigasi ke SignUp Page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          const RegisterScreen()),
                                    ),
                                  );
                                },
                                label: 'Daftar',
                                isExpand: true,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const HomeScreen();
          }
        });
  }
}
