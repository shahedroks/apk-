import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/category_item.dart';

class AddItemCategorySelection extends Notifier<CategoryItem?> {
  @override
  CategoryItem? build() => null;
}

class AddItemPhotoPaths extends Notifier<List<File>> {
  @override
  List<File> build() => [];
}

class AddItemLocation extends Notifier<String> {
  @override
  String build() => 'Local pickup';
}

final addItemCategoryProvider =
    NotifierProvider<AddItemCategorySelection, CategoryItem?>(
  AddItemCategorySelection.new,
);

final addItemPhotosProvider = NotifierProvider<AddItemPhotoPaths, List<File>>(
  AddItemPhotoPaths.new,
);

final addItemLocationProvider = NotifierProvider<AddItemLocation, String>(
  AddItemLocation.new,
);
