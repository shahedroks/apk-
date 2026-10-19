import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/firebase/collection_names.dart';
import '../models/listing_item.dart';
import 'item_repository.dart';

class SavedItemsRepository {
  SavedItemsRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    ItemRepository? itemRepository,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _items = itemRepository ?? ItemRepository();

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final ItemRepository _items;

  CollectionReference<Map<String, dynamic>>? _savedCol() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    return _firestore.collection(CollectionNames.savedItems(uid));
  }

  Stream<List<ListingItem>> watchSavedListings() {
    final col = _savedCol();
    if (col == null) return Stream.value(const []);

    return col.orderBy('savedAt', descending: true).snapshots().asyncMap(
      (snap) async {
        final listings = <ListingItem>[];
        for (final doc in snap.docs) {
          final item = await _items.getById(doc.id);
          if (item != null && item.status == 'approved') {
            listings.add(item);
          }
        }
        return listings;
      },
    );
  }

  Future<void> toggleSaved(String itemId) async {
    final col = _savedCol();
    if (col == null) return;
    final ref = col.doc(itemId);
    final snap = await ref.get();
    if (snap.exists) {
      await ref.delete();
    } else {
      await ref.set({
        'itemId': itemId,
        'savedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<bool> isSaved(String itemId) async {
    final col = _savedCol();
    if (col == null) return false;
    final snap = await col.doc(itemId).get();
    return snap.exists;
  }
}
