import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/data/collections/user.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';
import 'package:progmobile_flutter/viewmodels/state/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

final userRepositoryProvider = Provider((ref) => UserRepository());

final editProfileViewModelProvider =
    StateNotifierProvider<EditProfileViewModel, RegisterState>(
  (ref) => EditProfileViewModel(ref.read(userRepositoryProvider)),
);

class EditProfileViewModel extends StateNotifier<RegisterState> {
  final UserRepository _repository;

  EditProfileViewModel(this._repository) : super(RegisterState()) {
    _loadUserData();
  }

  void setPassword(String password) => state = state.copyWith(password: password);

  Future<void> _loadUserData() async {
    try {
      final fbUser = fb.FirebaseAuth.instance.currentUser;
      if (fbUser == null) return;

      final user = await _repository.fetchUserById(fbUser.uid);
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

  void setNome(String nome) => state = state.copyWith(nome: nome);
  void setCognome(String cognome) => state = state.copyWith(cognome: cognome);
  void setEmail(String email) => state = state.copyWith(email: email);
  void setCodiceFiscale(String cf) => state = state.copyWith(codiceFiscale: cf);

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final fbUser = fb.FirebaseAuth.instance.currentUser;
      if (fbUser == null) throw Exception('Utente non autenticato');

      if (state.password.isNotEmpty) {
        await fbUser.updatePassword(state.password);
      }

      final updatedUser = User(
        id: fbUser.uid,
        name: state.nome,
        cognome: state.cognome,
        email: state.email,
        codiceFiscale: state.codiceFiscale,
        password: state.password,
        ruolo: 'Giocatore',       
        preferiti: [],
      );


      await _repository.updateUser(updatedUser);

      state = state.copyWith(success: true, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: 'Errore aggiornamento profilo: $e', isLoading: false);
    }
  }
}