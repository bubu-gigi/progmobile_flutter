import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/core/providers.dart';
import 'package:progmobile_flutter/data/collections/user.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';

class EditProfileViewModel extends Notifier<RegisterState> {
  late final UserRepository _repository;

  @override
  RegisterState build() {
    _repository = ref.read(userRepositoryProvider);
    _loadUserData();
    return RegisterState();
  }

  void setPassword(String password) =>
      state = state.copyWith(password: password);

  void setNome(String nome) =>
      state = state.copyWith(nome: nome);

  void setCognome(String cognome) =>
      state = state.copyWith(cognome: cognome);

  void setEmail(String email) =>
      state = state.copyWith(email: email);

  void setCodiceFiscale(String cf) =>
      state = state.copyWith(codiceFiscale: cf);

  Future<void> _loadUserData() async {
    try {
      final session = ref.read(userSessionProvider);
      if (session == null) throw Exception('Sessione utente non trovata');

      final user = await _repository.fetchUserById(session.userId);
      if (user != null) {
        state = state.copyWith(
          nome: user.name,
          cognome: user.cognome,
          email: user.email,
          codiceFiscale: user.codiceFiscale,
        );
      }
    } catch (e) {
      state = state.copyWith(error: 'Errore nel caricamento profilo: $e');
    }
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final session = ref.read(userSessionProvider);
      if (session == null) throw Exception('Sessione utente non trovata');

      final updatedUser = User(
        id: session.userId,
        name: state.nome,
        cognome: state.cognome,
        email: state.email,
        codiceFiscale: state.codiceFiscale,
        password: state.password,
        ruolo: session.ruolo,
        preferiti: [], // eventualmente puoi caricare quelli attuali
      );

      await _repository.updateUser(updatedUser);

      state = state.copyWith(success: true, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Errore aggiornamento profilo: $e',
        isLoading: false,
      );
    }
  }
}