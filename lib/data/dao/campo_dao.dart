import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/campo.dart';

class CampoDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference getCampiRef(String strutturaId) {
    return _firestore
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi');
  }

  Future<void> addCampo(String strutturaId, Campo campo) async {
    final ref = getCampiRef(strutturaId).doc();
    final campoWithId = campo.copyWith(id: ref.id);
    await ref.set(campoWithId.toJson());
  }

  Future<void> updateCampo(String strutturaId, Campo campo) async {
    if (campo.id.isEmpty) {
      throw ArgumentError('Campo ID is required for update.');
    }

    final ref = getCampiRef(strutturaId).doc(campo.id);

    try {
      await ref.update(campo.toJson());
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw Exception('Il campo con ID ${campo.id} non esiste e non può essere aggiornato.');
      } else {
        throw Exception('Errore durante l\'aggiornamento: ${e.message}');
      }
    }
  }

  Future<void> deleteCampo(String strutturaId, String campoId) async {
    final ref = getCampiRef(strutturaId).doc(campoId);
    final doc = await ref.get();

    if (!doc.exists) {
      throw Exception('Il campo con ID $campoId non esiste.');
    }

    await ref.delete();
  }

  Future<List<Campo>> getCampi(String strutturaId) async {
    final snapshot = await getCampiRef(strutturaId).get();

    return snapshot.docs
        .map((doc) => Campo.fromJson(doc.data() as Map<String, dynamic>).copyWith(id: doc.id))
        .toList();
  }
}
