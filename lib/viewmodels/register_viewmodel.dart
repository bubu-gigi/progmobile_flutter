import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';
import '../data/collections/user.dart';
import '../repositories/user_repository.dart';
import '../core/providers.dart'; 

class RegisterViewModel extends Notifier<RegisterState> {
  late final UserRepository _userRepository;

  @override
  RegisterState build() {
    _userRepository = ref.read(userRepositoryProvider);
    return RegisterState();
  }

  void setNome(String nome) =>
      state = state.copyWith(nome: nome);

  void setCognome(String cognome) =>
      state = state.copyWith(cognome: cognome);

  void setEmail(String email) =>
      state = state.copyWith(email: email);

  void setCodiceFiscale(String cf) =>
      state = state.copyWith(codiceFiscale: cf);

  void setPassword(String password) =>
      state = state.copyWith(password: password);

  Future<void> register() async {
    state = state.copyWith(isLoading: true);

    try {
      final tempUser = User(
        id: '',
        codiceFiscale: state.codiceFiscale,
        cognome: state.cognome,
        email: state.email,
        name: state.nome,
        password: state.password,
        ruolo: 'Giocatore',
        preferiti: [],
      );

      await _userRepository.registerWithEmailAndPassword(
        tempUser,
        state.email,
        state.password,
      );

      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      print('Errore durante la registrazione: $e');
      state = state.copyWith(
        isLoading: false,
        success: false,
        error: 'Registrazione fallita: ${e.toString()}',
      );
    }
  }
}
