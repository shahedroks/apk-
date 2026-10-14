import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUiState {
  const LoginUiState({
    this.rememberMe = true,
    this.obscurePassword = true,
  });

  final bool rememberMe;
  final bool obscurePassword;

  LoginUiState copyWith({bool? rememberMe, bool? obscurePassword}) {
    return LoginUiState(
      rememberMe: rememberMe ?? this.rememberMe,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

class LoginUiNotifier extends Notifier<LoginUiState> {
  @override
  LoginUiState build() => const LoginUiState();

  void toggleRememberMe(bool? value) {
    state = state.copyWith(rememberMe: value ?? false);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }
}

final loginUiProvider =
    NotifierProvider<LoginUiNotifier, LoginUiState>(LoginUiNotifier.new);
