/// Secure token storage. Replace with `flutter_secure_storage` for production.
class SecureStorage {
  String? _token;

  Future<void> writeToken(String token) async {
    _token = token;
  }

  Future<String?> readToken() async => _token;

  Future<void> deleteToken() async {
    _token = null;
  }
}
