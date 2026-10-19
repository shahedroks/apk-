import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase/user_profile_service.dart';

/// Persists whether the user completed login so the app opens on home next time.
class AuthSession {
  AuthSession._();

  static const _loggedInKey = 'auth_logged_in';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    await setLoggedIn(user != null);
    if (user != null) {
      await syncFirestoreProfile();
    }
  }

  /// Backfills `users/{uid}` with `role: user` if sign-up sync failed earlier.
  static Future<bool> syncFirestoreProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    try {
      await UserProfileService().ensureAppUserProfile(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
      );
      return true;
    } catch (e, st) {
      debugPrint('AuthSession profile sync: $e\n$st');
      return false;
    }
  }

  static bool get isLoggedIn => _prefs?.getBool(_loggedInKey) ?? false;

  static Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(_loggedInKey, value);
  }

  static Future<void> clear() => setLoggedIn(false);

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await clear();
  }
}
