import 'package:flutter/foundation.dart';
import 'package:progmobile_flutter/data/collections/user.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';

import '../core/user_session.dart';

class EditProfileViewModel extends ChangeNotifier {
  late final UserRepository _repository;

  EditProfileViewModel() {
    _repository = UserRepository();
    currentUserSession = UserSessionManager().session;
    loadUserData();
  }


  String nome = '';
  String cognome = '';
  String email = '';
  String codiceFiscale = '';
  String password = '';
  bool isLoading = false;
  bool success = false;
  String? error;

  User? _currentUser;
  UserSession? currentUserSession;


  void setNome(String value) {
    nome = value;
    notifyListeners();
  }

  void setCognome(String value) {
    cognome = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setCodiceFiscale(String value) {
    codiceFiscale = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<void> loadUserData() async {
    isLoading = true;
    notifyListeners();

    try {
      final user = await _repository.fetchUserById(currentUserSession!.userId);
      print(user);
      if (user != null) {
        _currentUser = user;
        nome = user.name;
        cognome = user.cognome;
        email = user.email;
        codiceFiscale = user.codiceFiscale;
      }
    } catch (e) {
      error = 'Errore nel caricamento profilo: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> submit() async {
    if (_currentUser == null) return;

    isLoading = true;
    error = null;
    success = false;
    notifyListeners();

    try {
      final updatedUser = User(
        id: _currentUser!.id,
        name: nome,
        cognome: cognome,
        email: email,
        codiceFiscale: codiceFiscale,
        password: password,
        ruolo: _currentUser!.ruolo,
        preferiti: _currentUser!.preferiti,
      );

      await _repository.updateUser(updatedUser);

      success = true;
    } catch (e) {
      error = 'Errore aggiornamento profilo: $e';
    }

    isLoading = false;
    notifyListeners();
  }
}
