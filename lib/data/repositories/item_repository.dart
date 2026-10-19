import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/firebase/collection_names.dart';
import '../models/listing_item.dart';

class ItemRepository {
  ItemRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Stream<List<ListingItem>> watchApprovedListings({String? categoryId}) {
    Query<Map<String, dynamic>> query = _firestore
        .collection(CollectionNames.items)
        .where('status', isEqualTo: 'approved')
        .orderBy('createdAt', descending: true)
        .limit(50);

    if (categoryId != null && categoryId.isNotEmpty) {
      query = _firestore
          .collection(CollectionNames.items)
          .where('status', isEqualTo: 'approved')
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('createdAt', descending: true)
          .limit(50);
    }

    return query.snapshots().map(
      (snap) => snap.docs.map(ListingItem.fromFirestore).toList(),
    );
  }

  Stream<List<ListingItem>> watchMyListings() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return Stream.value(const []);
    }
    return _firestore
        .collection(CollectionNames.items)
        .where('ownerId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(ListingItem.fromFirestore).toList());
  }

  Future<ListingItem?> getById(String id) async {
    final doc = await _firestore.collection(CollectionNames.items).doc(id).get();
    if (!doc.exists) return null;
    return ListingItem.fromFirestore(doc);
  }

  Future<String> createListing(ListingItem draft) async {
    final ref = _firestore.collection(CollectionNames.items).doc();
    await ref.set(draft.toCreateMap());
    return ref.id;
  }

  Future<void> updateItem(String id, Map<String, dynamic> patch) async {
    await _firestore.collection(CollectionNames.items).doc(id).update({
      ...patch,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteItem(String id) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Sign in required');
    final doc = await _firestore.collection(CollectionNames.items).doc(id).get();
    if (!doc.exists || doc.data()?['ownerId'] != uid) {
      throw StateError('Not allowed');
    }
    await _firestore.collection(CollectionNames.items).doc(id).delete();
  }

  Stream<List<ListingItem>> watchPendingForOwner() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(const []);
    return _firestore
        .collection(CollectionNames.items)
        .where('ownerId', isEqualTo: uid)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(ListingItem.fromFirestore).toList());
  }
}
