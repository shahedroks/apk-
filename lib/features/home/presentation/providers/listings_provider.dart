import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/mappers/listing_mapper.dart';
import '../../../../data/models/listing_item.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../../data/repositories/item_repository.dart';
import '../../domain/models/swap_listing.dart';
import 'home_ui_provider.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(),
);

final itemRepositoryProvider = Provider<ItemRepository>(
  (ref) => ItemRepository(),
);

final categoryLabelsProvider = FutureProvider<List<String>>((ref) async {
  return ref.read(categoryRepositoryProvider).categoryLabels();
});

final approvedListingsProvider = StreamProvider<List<ListingItem>>((ref) {
  final index = ref.watch(discoverCategoryProvider);
  final labels = ref.watch(categoryLabelsProvider).value ?? const ['All'];
  final itemRepo = ref.watch(itemRepositoryProvider);

  return itemRepo.watchApprovedListings().map((items) {
    if (index <= 0 || index >= labels.length) return items;
    final label = labels[index];
    if (label == 'All') return items;
    return items.where((i) => i.categoryName == label).toList();
  });
});

final discoverSwapListingsProvider = Provider<AsyncValue<List<SwapListing>>>((ref) {
  return ref.watch(approvedListingsProvider).whenData(
    (items) => items.map(ListingMapper.toSwapListing).toList(),
  );
});

final myListingsProvider = StreamProvider<List<ListingItem>>((ref) {
  return ref.watch(itemRepositoryProvider).watchMyListings();
});
