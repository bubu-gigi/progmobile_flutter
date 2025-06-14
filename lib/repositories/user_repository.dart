import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../data/collections/user.dart';
import '../data/dao/user_dao.dart';

class UserRepository {
  final UserDao _dao = UserDao();
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  Future<User?> fetchUserById(String id) => _dao.getUserById(id);
  Future<void> createUser(User user) => _dao.createUser(user);
  Future<void> updateUser(User user) => _dao.updateUser(user);
  Future<void> deleteUser(String id) => _dao.deleteUser(id);

  Future<fb.User?> loginWithEmailAndPassword(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user;
  }

  Future<void> registerWithEmailAndPassword(User user, String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = cred.user!.uid;
    final newUser = user.copyWith(id: uid);
    await _dao.createUser(newUser);
  }

}
