import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProposeOfferSelection extends Notifier<int> {
  @override
  int build() => 0;
}

class AddItemConditionIndex extends Notifier<int> {
  @override
  int build() => 1;
}

class MyItemsTabIndex extends Notifier<int> {
  @override
  int build() => 0;
}

class WildcardSwapToggle extends Notifier<bool> {
  @override
  bool build() => false;
}

final proposeOfferIndexProvider =
    NotifierProvider<ProposeOfferSelection, int>(ProposeOfferSelection.new);

final addItemConditionProvider =
    NotifierProvider<AddItemConditionIndex, int>(AddItemConditionIndex.new);

final myItemsTabProvider =
    NotifierProvider<MyItemsTabIndex, int>(MyItemsTabIndex.new);

final wildcardSwapProvider =
    NotifierProvider<WildcardSwapToggle, bool>(WildcardSwapToggle.new);
