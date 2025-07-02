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

class UserSessionManager {
  static final UserSessionManager _instance = UserSessionManager._internal();
  factory UserSessionManager() => _instance;

  UserSessionManager._internal();

  UserSession? _userSession;

  UserSession? get session => _userSession;

  set session(UserSession? session) {
    _userSession = session;
  }

  void clear() {
    session = null;
  }

  bool get isLoggedIn => _userSession != null;
}
