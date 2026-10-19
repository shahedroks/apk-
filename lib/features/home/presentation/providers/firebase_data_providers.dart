import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/app_settings_repository.dart';
import '../../../../data/repositories/chat_repository.dart';
import '../../../../data/repositories/report_repository.dart';
import '../../../../data/repositories/saved_items_repository.dart';
import '../../../../data/repositories/swap_offer_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/services/listing_publish_service.dart';
import 'listings_provider.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepository());

final savedItemsRepositoryProvider =
    Provider<SavedItemsRepository>((ref) => SavedItemsRepository());

final swapOfferRepositoryProvider =
    Provider<SwapOfferRepository>((ref) => SwapOfferRepository());

final chatRepositoryProvider = Provider<ChatRepository>((ref) => ChatRepository());

final reportRepositoryProvider = Provider<ReportRepository>((ref) => ReportRepository());

final appSettingsRepositoryProvider =
    Provider<AppSettingsRepository>((ref) => AppSettingsRepository());

final listingPublishServiceProvider =
    Provider<ListingPublishService>((ref) => ListingPublishService());

final currentUserProvider = StreamProvider((ref) {
  return ref.watch(userRepositoryProvider).watchCurrentUser();
});

final savedListingsProvider = StreamProvider((ref) {
  return ref.watch(savedItemsRepositoryProvider).watchSavedListings();
});

final incomingOffersProvider = StreamProvider((ref) {
  return ref.watch(swapOfferRepositoryProvider).watchIncoming();
});

final activeSwapsProvider = StreamProvider((ref) {
  return ref.watch(swapOfferRepositoryProvider).watchActiveSwaps();
});

final matchesProvider = StreamProvider((ref) {
  return ref.watch(swapOfferRepositoryProvider).watchMatches();
});

final myChatsProvider = StreamProvider((ref) {
  return ref.watch(chatRepositoryProvider).watchMyChats();
});

final appSettingsProvider = StreamProvider((ref) {
  return ref.watch(appSettingsRepositoryProvider).watchAppSettings();
});

final itemDetailProvider = FutureProvider.family((ref, String itemId) async {
  return ref.watch(itemRepositoryProvider).getById(itemId);
});
