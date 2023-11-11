import 'package:flutter/material.dart';
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
      return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  provider.logOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: provider.emailVerified ?? false
              ? const Text('Email Verified')
              : const Text('Email Is Not Verified'));
    });
  }
}
