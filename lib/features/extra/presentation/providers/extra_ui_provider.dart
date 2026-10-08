import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationFilterIndex extends Notifier<int> {
  @override
  int build() => 0;
}

class ReviewFilterIndex extends Notifier<int> {
  @override
  int build() => 0;
}

class PublicProfileTabIndex extends Notifier<int> {
  @override
  int build() => 0;
}

final notificationFilterProvider =
    NotifierProvider<NotificationFilterIndex, int>(NotificationFilterIndex.new);

final reviewFilterProvider =
    NotifierProvider<ReviewFilterIndex, int>(ReviewFilterIndex.new);

final publicProfileTabProvider =
    NotifierProvider<PublicProfileTabIndex, int>(PublicProfileTabIndex.new);
