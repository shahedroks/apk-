import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/firebase/collection_names.dart';
import '../models/app_user.dart';

class UserRepository {
  UserRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Stream<AppUser?> watchCurrentUser() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(null);
    return _firestore
        .collection(CollectionNames.users)
        .doc(uid)
        .snapshots()
        .map((snap) => snap.exists ? AppUser.fromFirestore(snap) : null);
  }

  Future<AppUser?> getById(String uid) async {
    final snap = await _firestore.collection(CollectionNames.users).doc(uid).get();
    if (!snap.exists) return null;
    return AppUser.fromFirestore(snap);
  }

  Future<AppUser?> getByHandle(String handle) async {
    final snap = await _firestore
        .collection(CollectionNames.users)
        .where('handle', isEqualTo: handle)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return AppUser.fromFirestore(snap.docs.first);
  }

  Future<void> updateProfile(Map<String, dynamic> patch) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Sign in required');
    await _firestore.collection(CollectionNames.users).doc(uid).update({
      ...patch,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
