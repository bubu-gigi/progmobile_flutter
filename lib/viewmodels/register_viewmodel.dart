import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  final String nome;
  final String cognome;
  final String email;
  final String codiceFiscale;
  final String password;
  final bool isLoading;

  RegisterState({
    this.nome = '',
    this.cognome = '',
    this.email = '',
    this.codiceFiscale = '',
    this.password = '',
    this.isLoading = false,
  });

  RegisterState copyWith({
    String? nome,
    String? cognome,
    String? email,
    String? codiceFiscale,
    String? password,
    bool? isLoading,
  }) {
    return RegisterState(
      nome: nome ?? this.nome,
      cognome: cognome ?? this.cognome,
      email: email ?? this.email,
      codiceFiscale: codiceFiscale ?? this.codiceFiscale,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RegisterViewModel extends StateNotifier<RegisterState> {
  RegisterViewModel() : super(RegisterState());

  void setNome(String nome) => state = state.copyWith(nome: nome);
  void setCognome(String cognome) => state = state.copyWith(cognome: cognome);
  void setEmail(String email) => state = state.copyWith(email: email);
  void setCodiceFiscale(String cf) => state = state.copyWith(codiceFiscale: cf);
  void setPassword(String password) => state = state.copyWith(password: password);

  Future<void> register() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isLoading: false);
    // Gestisci il risultato della registrazione (success/fail)
  }
}

final registerViewModelProvider = StateNotifierProvider<RegisterViewModel, RegisterState>(
      (ref) => RegisterViewModel(),
);
