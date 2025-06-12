import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/viewmodels/state/login_state.dart';
import '../repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>(
      (ref) => LoginViewModel(ref.read(userRepositoryProvider)),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final UserRepository _userRepository;

  LoginViewModel(this._userRepository) : super(LoginState());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> login() async {
  state = state.copyWith(isLoading: true, success: false, error: null);

  try {
    final user = await _userRepository.loginWithEmailAndPassword(
      state.email,
      state.password,
    );

    if (user != null) {
      state = state.copyWith(isLoading: false, success: true);
    } else {
      state = state.copyWith(
        isLoading: false,
        success: false,
        error: 'Credenziali non valide',
      );
    }
  } catch (e) {
    print('Login failed: $e');
    state = state.copyWith(
      isLoading: false,
      success: false,
      error: 'Login fallito: ${e.toString()}',
    );
  }
}

}
