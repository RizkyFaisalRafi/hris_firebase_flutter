import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/preferences/user_preferences.dart';
import 'package:hris_firebase_flutter/routes/router_delegate.dart';
import 'package:hris_firebase_flutter/view_model/register_provider.dart';
import 'package:provider/provider.dart';

import 'view_model/login_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;

  @override
  void initState() {
    super.initState();

    final userPreferences = UserPreferences();
    myRouterDelegate = MyRouterDelegate(userPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'HRIS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const SplashScreen(),
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
