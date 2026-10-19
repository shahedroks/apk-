import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/providers/firebase_data_providers.dart';
import '../../../home/presentation/providers/listings_provider.dart';

class ProposeSwapService {
  ProposeSwapService(this.ref);

  final Ref ref;

  Future<String> submit({
    required String targetItemId,
    required String fromItemId,
    String? message,
  }) async {
    final target = await ref.read(itemRepositoryProvider).getById(targetItemId);
    if (target == null) throw StateError('Target item not found');
    return ref.read(swapOfferRepositoryProvider).createOffer(
          toUserId: target.ownerId,
          fromItemId: fromItemId,
          toItemId: targetItemId,
          message: message,
        );
  }
}

final proposeSwapServiceProvider = Provider<ProposeSwapService>(
  (ref) => ProposeSwapService(ref),
);
