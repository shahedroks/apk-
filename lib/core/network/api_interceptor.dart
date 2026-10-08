typedef ApiRequestHandler = Future<Map<String, dynamic>> Function();

/// Hook for auth headers, logging, and error mapping before/after requests.
class ApiInterceptor {
  Future<Map<String, dynamic>> intercept(ApiRequestHandler request) async {
    try {
      return await request();
    } catch (e) {
      rethrow;
    }
  }
}
