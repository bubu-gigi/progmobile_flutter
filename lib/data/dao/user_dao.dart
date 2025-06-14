import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/user.dart';

class UserDao {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<User?> getUserById(String id) async {
    final doc = await _usersRef.doc(id).get();

    if (!doc.exists) return null;

    return User.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }

  Future<void> createUser(User user) async {
    await _usersRef.doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(User user) async {
    if (user.id.isEmpty) {
      throw ArgumentError('User ID is required for update.');
    }

    final docRef = _usersRef.doc(user.id);

    try {
      await docRef.update(user.toJson());
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw Exception('L\'utente con ID ${user.id} non esiste e non può essere aggiornato.');
      } else {
        throw Exception('Errore durante l\'aggiornamento: ${e.message}');
      }
    }
  }

  Future<void> deleteUser(String id) async {
    final docRef = _usersRef.doc(id);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception('L\'utente con ID $id non esiste.');
    }

    await docRef.delete();
  }
}
