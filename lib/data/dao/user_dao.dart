import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserDao {
  final _usersRef = FirebaseFirestore.instance.collection('utenti');

  Future<UserModel?> getUserById(String id) async {
    final doc = await _usersRef.doc(id).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc.data()!, doc.id);
  }

  Future<void> createUser(UserModel user) async {
    await _usersRef.doc(user.id).set(user.toMap());
  }

  Future<void> updateUser(UserModel user) async {
    await _usersRef.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _usersRef.doc(id).delete();
  }

  Stream<List<UserModel>> watchAllUsers() {
    return _usersRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }
}
