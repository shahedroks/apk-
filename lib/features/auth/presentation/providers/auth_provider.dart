import 'package:flutter/foundation.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({LoginUseCase? loginUseCase})
      : _loginUseCase = loginUseCase ??
            LoginUseCase(AuthRepositoryImpl());

  final LoginUseCase _loginUseCase;

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _loginUseCase(email: email, password: password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
