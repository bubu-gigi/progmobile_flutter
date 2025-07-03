import '../data/collections/user.dart';

class UserSessionManager {
  static final UserSessionManager _instance = UserSessionManager._internal();
  factory UserSessionManager() => _instance;

  UserSessionManager._internal();

  User? _currentUser;

  bool get isLoggedIn => _currentUser != null;

  void clear() {
    _currentUser = null;
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  User? getCurrentUser() => _currentUser;
}
