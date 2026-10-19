import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/listing_item.dart';
import '../repositories/item_repository.dart';
import 'storage_service.dart';

class ListingPublishService {
  ListingPublishService({
    ItemRepository? itemRepository,
    StorageService? storageService,
    FirebaseAuth? auth,
  })  : _items = itemRepository ?? ItemRepository(),
        _storage = storageService ?? StorageService(),
        _auth = auth ?? FirebaseAuth.instance;

  final ItemRepository _items;
  final StorageService _storage;
  final FirebaseAuth _auth;

  Future<String> publish({
    required String title,
    required String description,
    required String wants,
    required String categoryId,
    required String categoryName,
    required String condition,
    required String location,
    List<File> photos = const [],
    String? estimatedValue,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('Sign in required');

    final draft = ListingItem(
      id: '',
      ownerId: user.uid,
      ownerName: user.displayName,
      title: title.trim(),
      description: description.trim(),
      wants: wants.trim(),
      categoryId: categoryId,
      categoryName: categoryName,
      condition: condition,
      location: location.trim(),
      imageUrls: const [],
      status: 'pending',
      estimatedValue: estimatedValue,
    );

    final itemId = await _items.createListing(draft);

    final urls = <String>[];
    for (var i = 0; i < photos.length; i++) {
      final url = await _storage.uploadItemImage(
        itemId: itemId,
        file: photos[i],
        index: i,
      );
      urls.add(url);
    }
    if (urls.isNotEmpty) {
      await _items.updateItem(itemId, {'imageUrls': urls});
    }

    return itemId;
  }
}
