import 'package:flutter/foundation.dart';
import '../repositories/user_repository.dart';
import '../core/user_session.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  LoginViewModel(this._userRepository);

  String email = '';
  String password = '';
  String role = '';
  bool isLoading = false;
  bool success = false;
  String? error;

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<void> login() async {
    isLoading = true;
    success = false;
    error = null;
    notifyListeners();

    try {
      final userCheck = await _userRepository.loginWithEmailAndPassword(
        email,
        password,
      );

      if (userCheck == null) {
        isLoading = false;
        error = 'Credenziali non valide';
        notifyListeners();
        return;
      }

      final user = await _userRepository.fetchUserById(userCheck.uid);

      if (user != null) {
        UserSessionManager().setCurrentUser(user);
        role = user.ruolo;
        success = true;
        isLoading = false;
      } else {
        isLoading = false;
        success = false;
        error = 'Utente non trovato';
      }
    } catch (e) {
      isLoading = false;
      success = false;
      error = 'Errore nel login: $e';
    }

    notifyListeners();
  }

  Future<void> eliminaAccountCorrente() async {
    isLoading = true;
    notifyListeners();

    try {
      final user = UserSessionManager().getCurrentUser();
      if (user != null) {
        await _userRepository.deleteUser(user.id);
        UserSessionManager().clear();
        success = true;
      } else {
        error = "Utente non trovato.";
        success = false;
      }
    } catch (e) {
      error = "Errore durante l'eliminazione: $e";
      success = false;
    }

    isLoading = false;
    notifyListeners();
  }

}
