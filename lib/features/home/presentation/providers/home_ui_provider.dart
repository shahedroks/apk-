import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

class DiscoverCategoryNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

class SavedCategoryNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

class ChatFilterNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

class SwapsTabNotifier extends Notifier<int> {
  @override
  int build() => 0;
}

final homeTabIndexProvider =
    NotifierProvider<HomeTabIndexNotifier, int>(HomeTabIndexNotifier.new);

final discoverCategoryProvider =
    NotifierProvider<DiscoverCategoryNotifier, int>(DiscoverCategoryNotifier.new);

final savedCategoryProvider =
    NotifierProvider<SavedCategoryNotifier, int>(SavedCategoryNotifier.new);

final chatFilterProvider =
    NotifierProvider<ChatFilterNotifier, int>(ChatFilterNotifier.new);

final swapsTabProvider =
    NotifierProvider<SwapsTabNotifier, int>(SwapsTabNotifier.new);
