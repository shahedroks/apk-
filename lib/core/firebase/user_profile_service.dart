import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'user_roles.dart';

class ProfileSyncException implements Exception {
  ProfileSyncException(this.message);
  final String message;

  @override
  String toString() => message;
}

class UserProfileService {
  UserProfileService({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  static const _collection = 'users';
  static const _maxAttempts = 4;

  Future<String> ensureAppUserProfile({
    required String uid,
    required String email,
    String? displayName,
  }) async {
    Object? lastError;
    for (var attempt = 1; attempt <= _maxAttempts; attempt++) {
      try {
        await _waitForAuthToken(uid: uid);
        return await _ensureAppUserProfileOnce(
          uid: uid,
          email: email,
          displayName: displayName,
        );
      } on FirebaseException catch (e, st) {
        lastError = _mapFirestoreError(e);
        debugPrint('UserProfileService attempt $attempt failed: $e\n$st');
      } catch (e, st) {
        lastError = e;
        debugPrint('UserProfileService attempt $attempt failed: $e\n$st');
        if (attempt < _maxAttempts) {
          await Future<void>.delayed(Duration(milliseconds: 400 * attempt));
        }
      }
    }
    throw ProfileSyncException(
      lastError is ProfileSyncException
          ? lastError.message
          : 'Could not save your profile (role) to the database. '
              'Check internet, enable Firestore in Firebase Console, '
              'then log in again.',
    );
  }

  Future<void> _waitForAuthToken({required String uid}) async {
    User? user = _firebaseAuth.currentUser;
    for (var i = 0; i < 8 && user == null; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      user = _firebaseAuth.currentUser;
    }
    if (user == null || user.uid != uid) {
      throw ProfileSyncException('Sign-in session was not ready. Try again.');
    }
    await user.getIdToken(true);
  }

  Future<String> _ensureAppUserProfileOnce({
    required String uid,
    required String email,
    String? displayName,
  }) async {
    final ref = _firestore.collection(_collection).doc(uid);
    final snap = await ref.get();

    if (snap.exists) {
      final role = snap.data()?['role'] as String?;
      return role ?? UserRoles.user;
    }

    final payload = <String, dynamic>{
      'email': email.trim(),
      'role': UserRoles.user,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) {
      payload['displayName'] = name;
    }

    await ref.set(payload);

    return UserRoles.user;
  }

  ProfileSyncException _mapFirestoreError(FirebaseException e) {
    if (e.code == 'permission-denied') {
      return ProfileSyncException(
        'Firestore rules are blocking profile save. In Firebase Console open '
        'Firestore → Rules → paste rules from ADMIN_PANALE/firestore.rules → Publish.',
      );
    }
    if (e.code == 'unavailable') {
      return ProfileSyncException(
        'Firestore is unavailable. Check internet and Google Play services, then try again.',
      );
    }
    return ProfileSyncException(
      e.message ?? 'Could not save profile to Firestore (${e.code}).',
    );
  }

  Future<String> fetchRole(String uid) async {
    await _waitForAuthToken(uid: uid);
    final snap = await _firestore.collection(_collection).doc(uid).get();
    if (!snap.exists) return UserRoles.user;
    return snap.data()?['role'] as String? ?? UserRoles.user;
  }
}
