import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.login({
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response);
  }
}
