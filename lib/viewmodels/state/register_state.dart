class RegisterState {
  final String nome;
  final String cognome;
  final String email;
  final String codiceFiscale;
  final String password;
  final bool isLoading;
  final bool success;
  final String error;

  RegisterState({
    this.nome = '',
    this.cognome = '',
    this.email = '',
    this.codiceFiscale = '',
    this.password = '',
    this.isLoading = false,
    this.success = false,
    this.error = '',
  });

  RegisterState copyWith({
    String? nome,
    String? cognome,
    String? email,
    String? codiceFiscale,
    String? password,
    bool? isLoading,
    bool? success,
    String? error,
  }) {
    return RegisterState(
      nome: nome ?? this.nome,
      cognome: cognome ?? this.cognome,
      email: email ?? this.email,
      codiceFiscale: codiceFiscale ?? this.codiceFiscale,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
