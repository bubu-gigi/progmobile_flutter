class UserSession {
  final String userId;
  final String nameAndSurname;
  final String ruolo;

  const UserSession({
    required this.userId,
    required this.ruolo,
    required this.nameAndSurname,
  });
}
