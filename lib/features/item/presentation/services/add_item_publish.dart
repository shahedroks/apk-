import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/category_item.dart';
import '../../../home/presentation/providers/firebase_data_providers.dart';
import '../../../home/presentation/providers/listings_provider.dart';
import '../providers/add_item_providers.dart';
class AddItemPublish {
  AddItemPublish(this.ref);

  final Ref ref;

  Future<String> publish({
    required String title,
    required String description,
    required String wants,
    required int conditionIndex,
    required List<String> conditionLabels,
  }) async {
    CategoryItem? category = ref.read(addItemCategoryProvider);
    if (category == null) {
      final labels = await ref.read(categoryRepositoryProvider).categoryLabels();
      final name = labels.length > 1 ? labels[1] : 'Electronics';
      category = await ref.read(categoryRepositoryProvider).getByName(name);
      category ??= CategoryItem(
        id: name.toLowerCase(),
        name: name,
        slug: name.toLowerCase(),
        sortOrder: 0,
        active: true,
      );
    }

    final condition = conditionLabels[conditionIndex.clamp(0, conditionLabels.length - 1)];
    final location = ref.read(addItemLocationProvider);
    final photos = ref.read(addItemPhotosProvider);

    return ref.read(listingPublishServiceProvider).publish(
          title: title,
          description: description,
          wants: wants,
          categoryId: category.id,
          categoryName: category.name,
          condition: condition,
          location: location,
          photos: photos,
        );
  }
}

final addItemPublishProvider = Provider<AddItemPublish>((ref) => AddItemPublish(ref));
