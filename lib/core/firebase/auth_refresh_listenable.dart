import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../storage/auth_session.dart';

/// Notifies [GoRouter] when Firebase Auth session changes.
class AuthRefreshListenable extends ChangeNotifier {
  AuthRefreshListenable() {
    _sub = FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      await AuthSession.setLoggedIn(user != null);
      if (user != null) {
        await AuthSession.syncFirestoreProfile();
      }
      notifyListeners();
    });
  }

  late final StreamSubscription<User?> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
