import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  final String loginState = "login";
  final String bearerKey = "bearerKey";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loginState) ?? false;
  }

  Future<bool> login() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(loginState, true);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(loginState, false);
  }

  Future saveBearerToken(String bearer) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(bearerKey, bearer);
  }

  Future getBearerToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(bearerKey);
  }
}
