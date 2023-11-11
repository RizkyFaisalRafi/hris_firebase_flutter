import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/common/home.dart';
import 'package:hris_firebase_flutter/view/login_screen.dart';
import 'package:hris_firebase_flutter/view_model/home_provider.dart';
import 'package:hris_firebase_flutter/view_model/register_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<RegisterProvider>(context, listen: false);
    if (mounted) {
      authProvider.updateEmailVerificationState();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(builder: (context, provider, _) {
      return Consumer<HomeProvider>(builder: (context, bodyNav, _) {
        return Scaffold(
          body: provider.emailVerified ?? true
              ? const Home()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Email Is Not Verified'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                            provider.logOut();
                          },
                          child: const Text('Log Out'))
                    ],
                  ),
                ),
        );
      });
    });
  }
}
