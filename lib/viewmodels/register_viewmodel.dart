import 'package:flutter/foundation.dart';
import '../data/collections/user.dart';
import '../repositories/user_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  String nome = '';
  String cognome = '';
  String email = '';
  String codiceFiscale = '';
  String password = '';
  bool isLoading = false;
  bool success = false;
  String error = '';

  RegisterViewModel(this._userRepository);

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

  Future<void> register() async {
    isLoading = true;
    error = '';
    success = false;
    notifyListeners();

    try {
      final tempUser = User(
        id: '',
        name: nome,
        cognome: cognome,
        email: email,
        codiceFiscale: codiceFiscale,
        password: password,
        ruolo: 'Giocatore',
        preferiti: [],
      );

      await _userRepository.registerWithEmailAndPassword(
        tempUser,
        email,
        password,
      );

      isLoading = false;
      success = true;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      error = 'Errore registrazione: $e';
      notifyListeners();
    }
  }
}
