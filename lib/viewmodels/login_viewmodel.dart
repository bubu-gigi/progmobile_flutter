import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/core/user_session.dart';
import 'package:progmobile_flutter/viewmodels/state/login_state.dart';
import '../repositories/user_repository.dart';

class LoginViewModel extends Notifier<LoginState> {
  late final UserRepository _userRepository;

  @override
  LoginState build() {
    _userRepository = ref.read(userRepositoryProvider);
    return LoginState(); // stato iniziale
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true, success: false, error: null);

    try {
      final userCheck = await _userRepository.loginWithEmailAndPassword(
        state.email,
        state.password,
      );

      final user = await _userRepository.fetchUserById(userCheck!.uid);

      if (user != null) {
        ref.read(userSessionProvider.notifier).state = UserSession(
          userId: user.id,
          ruolo: user.ruolo,
          nameAndSurname: "${user.name} ${user.cognome}"
        );
        state = state.copyWith(isLoading: false, success: true, role: user.ruolo);
      } else {
        state = state.copyWith(
          isLoading: false,
          success: false,
          error: 'Credenziali non valide',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        success: false,
        error: 'Login fallito: ${e.toString()}',
      );
    }
  }
}
