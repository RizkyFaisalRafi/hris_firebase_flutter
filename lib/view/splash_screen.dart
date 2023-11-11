import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/view/home_screen.dart';
import 'package:hris_firebase_flutter/view/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Menampilkan SplashScreen selama proses pengecekan login berlangsung
        if (snapshot.connectionState == ConnectionState.waiting) {
          log('ConnectionState.waiting');
        }
        // Cek apakah data sudah ada (pengguna sudah login)
        else if (snapshot.hasData) {
          log('snapshot has data');
          Future.delayed(const Duration(seconds: 5), () {
            log('Sudah Login');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          });
        } else {
          log('Else');

          // Jika belum, tampilkan SplashScreen
          Future.delayed(const Duration(seconds: 5), () {
            // Gunakan Navigator untuk beralih ke halaman berikutnya (LoginScreen)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo_app.png',
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
