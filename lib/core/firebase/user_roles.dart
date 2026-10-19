/// Shared with ADMIN_PANALE via Firestore `users/{uid}.role`.
class UserRoles {
  UserRoles._();

  static const String user = 'user';
  static const String admin = 'admin';
  static const String manager = 'manager';
  static const String viewer = 'viewer';

  static const Set<String> adminPanelRoles = {admin, manager, viewer};
}
