import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/view_model/home_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: true);

    return Scaffold(
      body: provider.bodyNavigation(),
      bottomNavigationBar: provider.bottomNav(),
    );
  }
}
