import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 0 = monthly, 1 = annual billing toggle.
class BillingCadenceIndex extends Notifier<int> {
  @override
  int build() => 1;
}

class UpgradeBillingIndex extends Notifier<int> {
  @override
  int build() => 1;
}

final billingCadenceProvider =
    NotifierProvider<BillingCadenceIndex, int>(BillingCadenceIndex.new);

final upgradeBillingProvider =
    NotifierProvider<UpgradeBillingIndex, int>(UpgradeBillingIndex.new);
