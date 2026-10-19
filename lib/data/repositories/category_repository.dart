import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/firebase/collection_names.dart';
import '../models/category_item.dart';

class CategoryRepository {
  CategoryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _fallbackNames = [
    'All',
    'Electronics',
    'Home',
    'Books',
    'Clothes',
    'Sports',
    'Music',
    'Art',
    'Toys',
    'Garden',
    'Tools',
  ];

  Stream<List<CategoryItem>> watchActiveCategories() {
    return _firestore
        .collection(CollectionNames.categories)
        .where('active', isEqualTo: true)
        .orderBy('sortOrder')
        .snapshots()
        .map((snap) => snap.docs.map(CategoryItem.fromFirestore).toList());
  }

  Future<List<String>> categoryLabels({bool includeAll = true}) async {
    try {
      final snap = await _firestore
          .collection(CollectionNames.categories)
          .where('active', isEqualTo: true)
          .orderBy('sortOrder')
          .get();
      if (snap.docs.isEmpty) {
        return includeAll ? _fallbackNames : _fallbackNames.skip(1).toList();
      }
      final names = snap.docs.map((d) => d.data()['name'] as String).toList();
      if (!includeAll) return names;
      return ['All', ...names];
    } catch (_) {
      return includeAll ? _fallbackNames : _fallbackNames.skip(1).toList();
    }
  }

  Future<CategoryItem?> getByName(String name) async {
    final snap = await _firestore
        .collection(CollectionNames.categories)
        .where('name', isEqualTo: name)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return CategoryItem.fromFirestore(snap.docs.first);
  }
}
