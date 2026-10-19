import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'user_profile_service.dart';

String firebaseAuthMessage(Object error) {
  if (error is ProfileSyncException) {
    return error.message;
  }
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return error.message ?? 'Authentication failed.';
    }
  }

  final message = error.toString();
  if (error is PlatformException &&
      (error.code == 'channel-error' || message.contains('channel-error'))) {
    return 'Could not reach the database. Enable Firestore in Firebase Console, '
        'then stop the app and run it again (full rebuild, not hot reload).';
  }
  if (message.contains('cloud_firestore') && message.contains('channel-error')) {
    return 'Could not reach the database. Enable Firestore in Firebase Console, '
        'then stop the app and run it again (full rebuild, not hot reload).';
  }
  if (message.contains('permission-denied')) {
    return 'Database access denied. Deploy Firestore rules for project swap-it-1.';
  }
  if (message.contains('unavailable')) {
    return 'Database is unavailable. Check your internet connection and try again.';
  }

  return message;
}
