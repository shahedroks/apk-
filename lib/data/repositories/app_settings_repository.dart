import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/firebase/collection_names.dart';

class AppSettingsRepository {
  AppSettingsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<Map<String, dynamic>?> watchAppSettings() {
    return _firestore
        .collection(CollectionNames.settings)
        .doc('app')
        .snapshots()
        .map((snap) => snap.data());
  }

  Future<Map<String, dynamic>?> getAppSettings() async {
    final snap = await _firestore.collection(CollectionNames.settings).doc('app').get();
    return snap.data();
  }
}
