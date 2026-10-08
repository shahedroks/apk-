import '../config/env_config.dart';
import '../constants/api_endpoints.dart';

/// HTTP client wrapper. Replace with `http` or `dio` when integrating APIs.
class ApiClient {
  ApiClient({String? baseUrl}) : _baseUrl = baseUrl ?? EnvConfig.baseUrl;

  final String _baseUrl;

  String url(String path) => '$_baseUrl$path';

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    // Stub: wire to real HTTP client.
    return <String, dynamic>{'path': path, 'body': body};
  }

  Future<Map<String, dynamic>> get(String path) async {
    return <String, dynamic>{'path': path};
  }
}

extension ApiClientEndpoints on ApiClient {
  Future<Map<String, dynamic>> login(Map<String, dynamic> body) =>
      post(ApiEndpoints.login, body: body);
}
