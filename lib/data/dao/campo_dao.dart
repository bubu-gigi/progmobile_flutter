import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/campo.dart';

class CampoDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCampo(String strutturaId, Campo campo) async {
    final ref = _firestore
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .doc();

    final campoWithId = campo.copyWith(id: ref.id);
    await ref.set(campoWithId.toJson());
  }

  Future<void> updateCampo(String strutturaId, Campo campo) async {
    if (campo.id.isEmpty) {
      throw ArgumentError('Campo ID is required for update.');
    }

    final ref = _firestore
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .doc(campo.id);

    await ref.set(campo.toJson());
  }

  Future<void> deleteCampo(String strutturaId, String campoId) async {
    await _firestore
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .doc(campoId)
        .delete();
  }

  Future<List<Campo>> getCampi(String strutturaId) async {
    final snapshot = await _firestore
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .get();

    return snapshot.docs
        .map((doc) => Campo.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }
}
