import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/struttura.dart';

class StrutturaDao {
  final CollectionReference struttureRef =
      FirebaseFirestore.instance.collection('strutture');

  Future<void> addStruttura(Struttura struttura) async {
    final docRef = struttureRef.doc();
    final strutturaWithId = struttura.copyWith(id: docRef.id);
    await docRef.set(strutturaWithId.toJson());
  }

  Future<void> updateStruttura(Struttura struttura) async {
    if (struttura.id.isEmpty) {
      throw ArgumentError('Struttura ID is required for update.');
    }

    final docRef = struttureRef.doc(struttura.id);

    try {
      await docRef.update(struttura.toJson());
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw Exception(
            'La struttura con ID ${struttura.id} non esiste e non può essere aggiornata.');
      } else {
        throw Exception('Errore durante l\'aggiornamento: ${e.message}');
      }
    }
  }

  Future<void> deleteStruttura(String id) async {
    final docRef = struttureRef.doc(id);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception('La struttura con ID $id non esiste.');
    }

    await docRef.delete();
  }

  Future<List<Struttura>> getStrutture() async {
    final snapshot = await struttureRef.get();

    return snapshot.docs.map((doc) {
      return Struttura.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }).toList();
  }

  Future<Struttura?> getStrutturaById(String id) async {
    final doc = await struttureRef.doc(id).get();

    if (!doc.exists) return null;

    return Struttura.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }
}
