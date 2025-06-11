class User {
  final String id;
  final String codiceFiscale;
  final String cognome;
  final String email;
  final String name;
  final String password;
  final String ruolo;
  final List<String> preferiti;

  User({
    required this.id,
    required this.codiceFiscale,
    required this.cognome,
    required this.email,
    required this.name,
    required this.password,
    required this.ruolo,
    required this.preferiti,
  });

  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      id: id,
      codiceFiscale: data['codiceFiscale'] ?? '',
      cognome: data['cognome'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      password: data['password'] ?? '',
      ruolo: data['ruolo'] ?? '',
      preferiti: List<String>.from(data['preferiti'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codiceFiscale': codiceFiscale,
      'cognome': cognome,
      'email': email,
      'name': name,
      'password': password,
      'ruolo': ruolo,
      'preferiti': preferiti,
    };
  }
}
