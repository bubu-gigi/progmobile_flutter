import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSession {
  final String userId;
  final String ruolo;

  const UserSession({
    required this.userId,
    required this.ruolo,
  });
}

final userSessionProvider = StateProvider<UserSession?>((ref) => null);