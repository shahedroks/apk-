import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/firebase/collection_names.dart';
import '../models/swap_offer.dart';

class SwapOfferRepository {
  SwapOfferRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String? _uid() => _auth.currentUser?.uid;

  Stream<List<SwapOffer>> watchIncoming() {
    final uid = _uid();
    if (uid == null) return Stream.value(const []);
    return _firestore
        .collection(CollectionNames.swapOffers)
        .where('toUserId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map(SwapOffer.fromFirestore).toList());
  }

  Stream<List<SwapOffer>> watchOutgoing() {
    final uid = _uid();
    if (uid == null) return Stream.value(const []);
    return _firestore
        .collection(CollectionNames.swapOffers)
        .where('fromUserId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map(SwapOffer.fromFirestore).toList());
  }

  Stream<List<SwapOffer>> watchActiveSwaps() {
    final uid = _uid();
    if (uid == null) return Stream.value(const []);
    return watchOutgoing().asyncMap((outgoing) async {
      final incoming = await _firestore
          .collection(CollectionNames.swapOffers)
          .where('toUserId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .get();
      final all = [
        ...outgoing,
        ...incoming.docs.map(SwapOffer.fromFirestore),
      ];
      return all
          .where((o) => o.status != 'declined' && o.status != 'cancelled')
          .toList();
    });
  }

  Stream<List<SwapOffer>> watchMatches() {
    final uid = _uid();
    if (uid == null) return Stream.value(const []);
    return _firestore
        .collection(CollectionNames.swapOffers)
        .where('fromUserId', isEqualTo: uid)
        .where('status', whereIn: ['accepted', 'completed'])
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map(SwapOffer.fromFirestore).toList());
  }

  Future<SwapOffer?> getById(String id) async {
    final doc = await _firestore.collection(CollectionNames.swapOffers).doc(id).get();
    if (!doc.exists) return null;
    return SwapOffer.fromFirestore(doc);
  }

  Future<String> createOffer({
    required String toUserId,
    required String fromItemId,
    required String toItemId,
    String? message,
  }) async {
    final uid = _uid();
    if (uid == null) throw StateError('Sign in required');

    final ref = _firestore.collection(CollectionNames.swapOffers).doc();
    await ref.set({
      'fromUserId': uid,
      'toUserId': toUserId,
      'fromItemId': fromItemId,
      'toItemId': toItemId,
      'message': message,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  Future<void> respondToOffer(String offerId, {required bool accept}) async {
    await _firestore.collection(CollectionNames.swapOffers).doc(offerId).update({
      'status': accept ? 'accepted' : 'declined',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> markCompleted(String offerId) async {
    await _firestore.collection(CollectionNames.swapOffers).doc(offerId).update({
      'status': 'completed',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
