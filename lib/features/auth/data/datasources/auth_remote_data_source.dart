import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/firebase/user_profile_service.dart';
import '../../../../core/firebase/user_roles.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    UserProfileService? userProfileService,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userProfileService = userProfileService ?? UserProfileService();

  final FirebaseAuth _firebaseAuth;
  final UserProfileService _userProfileService;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(code: 'user-not-found');
    }
    return _userFromFirebaseUser(user, fallbackEmail: email);
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user;
    if (user != null && name.trim().isNotEmpty) {
      await user.updateDisplayName(name.trim());
      await user.reload();
      await user.getIdToken(true);
    }
    final fresh = _firebaseAuth.currentUser ?? credential.user;
    if (fresh == null) {
      throw FirebaseAuthException(code: 'user-not-found');
    }
    return _userFromFirebaseUser(
      fresh,
      fallbackEmail: email,
      fallbackName: name,
      requireProfileSync: false,
    );
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  Future<UserModel> _userFromFirebaseUser(
    User user, {
    required String fallbackEmail,
    String? fallbackName,
    bool requireProfileSync = false,
  }) async {
    final email = user.email ?? fallbackEmail.trim();
    final displayName = user.displayName ?? fallbackName;
    var role = UserRoles.user;
    try {
      role = await _userProfileService.ensureAppUserProfile(
        uid: user.uid,
        email: email,
        displayName: displayName,
      );
    } catch (e, st) {
      debugPrint('Profile sync failed after auth: $e\n$st');
      if (requireProfileSync) rethrow;
    }

    return UserModel(
      id: user.uid,
      email: email,
      name: displayName,
      role: role,
    );
  }
}
