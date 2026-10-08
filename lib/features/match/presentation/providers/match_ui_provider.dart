import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchFilterIndex extends Notifier<int> {
  @override
  int build() => 0;
}

final matchFilterProvider =
    NotifierProvider<MatchFilterIndex, int>(MatchFilterIndex.new);
