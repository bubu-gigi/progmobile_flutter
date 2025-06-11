import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/user.dart';

class UserDao {
  final _usersRef = FirebaseFirestore.instance.collection('utenti');

  Future<User?> getUserById(String id) async {
    final doc = await _usersRef.doc(id).get();
    if (!doc.exists) return null;
    final user = User.fromJson(doc.data()!);
    user.id = doc.id;
    return user;
  }

  Future<void> createUser(User user) async {
    await _usersRef.doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(User user) async {
    if (user.id.isEmpty) {
      throw ArgumentError('User ID is required for update.');
    }
    await _usersRef.doc(user.id).update(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await _usersRef.doc(id).delete();
  }

  Stream<List<User>> watchAllUsers() {
    return _usersRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = User.fromJson(doc.data());
        user.id = doc.id;
        return user;
      }).toList();
    });
  }
}
