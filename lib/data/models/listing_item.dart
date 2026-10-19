import 'package:cloud_firestore/cloud_firestore.dart';

class ListingItem {
  const ListingItem({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.wants,
    required this.categoryId,
    required this.categoryName,
    required this.condition,
    required this.location,
    required this.imageUrls,
    required this.status,
    this.ownerName,
    this.estimatedValue,
    this.moderationNote,
    this.flagKind,
    this.flagTitle,
    this.flagMessage,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String ownerId;
  final String? ownerName;
  final String title;
  final String description;
  final String wants;
  final String categoryId;
  final String categoryName;
  final String condition;
  final String location;
  final List<String> imageUrls;
  final String status;
  final String? estimatedValue;
  final String? moderationNote;
  final String? flagKind;
  final String? flagTitle;
  final String? flagMessage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ListingItem.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return ListingItem(
      id: doc.id,
      ownerId: data['ownerId'] as String? ?? '',
      ownerName: data['ownerName'] as String?,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      wants: data['wants'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      categoryName: data['categoryName'] as String? ?? '',
      condition: data['condition'] as String? ?? '',
      location: data['location'] as String? ?? '',
      imageUrls: List<String>.from(data['imageUrls'] as List? ?? []),
      status: data['status'] as String? ?? 'pending',
      estimatedValue: data['estimatedValue'] as String?,
      moderationNote: data['moderationNote'] as String?,
      flagKind: data['flagKind'] as String?,
      flagTitle: data['flagTitle'] as String?,
      flagMessage: data['flagMessage'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'ownerId': ownerId,
      if (ownerName != null) 'ownerName': ownerName,
      'title': title,
      'description': description,
      'wants': wants,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'condition': condition,
      'location': location,
      'imageUrls': imageUrls,
      'status': status,
      if (estimatedValue != null) 'estimatedValue': estimatedValue,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
