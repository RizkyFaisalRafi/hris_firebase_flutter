import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hris_firebase_flutter/preferences/user_preferences.dart';
import 'package:hris_firebase_flutter/view/home_screen.dart';
import 'package:hris_firebase_flutter/view/login_screen.dart';

import '../view/register_screen.dart';
import '../view/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final UserPreferences preferences;

  MyRouterDelegate(this.preferences)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    await Future.delayed(const Duration(seconds: 2));
    isLoggedIn = await preferences.isLoggedIn();
    log("Cek Status Login $isLoggedIn");
    notifyListeners();
  }

  bool? isLoggedIn;
  List<Page> historyStack = [];
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {
    throw UnimplementedError();
  }

  // _splashStack
  List<Page> get _splashStack => const [
        // SplashScreen
        MaterialPage(
          key: ValueKey("SplashScreen"),
          child: SplashScreen(),
        ),
      ];

  // _loggedInStack
  List<Page> get _loggedInStack => [
        // HomeScreen
        const MaterialPage(
          key: ValueKey("HomeScreen"),
          child: HomeScreen(),
        ),

        // 
      ];

  // _loggedOutStack
  List<Page> get _loggedOutStack => [
        // LoginScreen
        MaterialPage(
          key: const ValueKey("LoginScreen"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),

        // RegisterScreen
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterScreen"),
            child: RegisterScreen(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];
}
