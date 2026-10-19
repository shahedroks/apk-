import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryItem {
  const CategoryItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.sortOrder,
    required this.active,
  });

  final String id;
  final String name;
  final String slug;
  final int sortOrder;
  final bool active;

  factory CategoryItem.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return CategoryItem(
      id: doc.id,
      name: data['name'] as String? ?? '',
      slug: data['slug'] as String? ?? doc.id,
      sortOrder: (data['sortOrder'] as num?)?.toInt() ?? 0,
      active: data['active'] as bool? ?? true,
    );
  }
}
