import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInquiriesToggle extends Notifier<bool> {
  @override
  bool build() => true;
}

class StatusAlertsToggle extends Notifier<bool> {
  @override
  bool build() => true;
}

class ApproxLocationToggle extends Notifier<bool> {
  @override
  bool build() => true;
}

final swapInquiriesToggleProvider =
    NotifierProvider<SwapInquiriesToggle, bool>(SwapInquiriesToggle.new);

final statusAlertsToggleProvider =
    NotifierProvider<StatusAlertsToggle, bool>(StatusAlertsToggle.new);

final approxLocationToggleProvider =
    NotifierProvider<ApproxLocationToggle, bool>(ApproxLocationToggle.new);
