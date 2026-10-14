import 'package:shared_preferences/shared_preferences.dart';

/// Persists whether the user completed login so the app opens on home next time.
class AuthSession {
  AuthSession._();

  static const _loggedInKey = 'auth_logged_in';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static bool get isLoggedIn => _prefs?.getBool(_loggedInKey) ?? false;

  static Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(_loggedInKey, value);
  }

  static Future<void> clear() => setLoggedIn(false);
}
