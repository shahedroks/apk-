/// Firestore collection paths shared with ADMIN_PANALE (see FIREBASE_SCHEMA.md).
class CollectionNames {
  CollectionNames._();

  static const users = 'users';
  static const categories = 'categories';
  static const items = 'items';
  static const swapOffers = 'swapOffers';
  static const chats = 'chats';
  static const reports = 'reports';
  static const settings = 'settings';
  static const subscriptions = 'subscriptions';

  static String savedItems(String uid) => 'users/$uid/savedItems';
}
