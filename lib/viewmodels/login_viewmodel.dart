// lib/viewmodels/login_viewmodel.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider = ChangeNotifierProvider((ref) => LoginViewModel());

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Simula chiamata

    _isLoading = false;
    notifyListeners();
  }
}
