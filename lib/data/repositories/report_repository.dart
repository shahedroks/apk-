import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/firebase/collection_names.dart';

class ReportRepository {
  ReportRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<void> submit({
    required String type,
    required String targetType,
    String? targetId,
    String? title,
    required String message,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Sign in required');

    await _firestore.collection(CollectionNames.reports).add({
      'type': type,
      'reporterId': uid,
      'targetType': targetType,
      'targetId': targetId,
      'title': title,
      'message': message,
      'status': 'open',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
