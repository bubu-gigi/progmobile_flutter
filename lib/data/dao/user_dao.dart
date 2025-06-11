import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/user.dart';

class UserDao {
  final _usersRef = FirebaseFirestore.instance.collection('utenti');

  Future<User?> getUserById(String id) async {
    final doc = await _usersRef.doc(id).get();
    if (!doc.exists) return null;
    return User.fromJson(doc.data()!).copyWith(id: doc.id);
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
        return User.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }
}
