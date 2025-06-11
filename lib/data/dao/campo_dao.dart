import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/campo.dart';

class CampoDao {
  Future<void> addCampo(String strutturaId, Campo campo) async {
    final ref = FirebaseFirestore.instance
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .doc();
    campo.id = ref.id;
    await ref.set(campo.toMap());
  }

  Future<void> updateCampo(String strutturaId, Campo campo) async {
    final ref = FirebaseFirestore.instance
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .doc(campo.id);
    await ref.set(campo.toMap());
  }

  Future<void> deleteCampo(String strutturaId, String campoId) async {
    await FirebaseFirestore.instance
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .doc(campoId)
        .delete();
  }

  Future<List<Campo>> getCampi(String strutturaId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('strutture')
        .doc(strutturaId)
        .collection('campi')
        .get();

    return snapshot.docs
        .map((doc) => Campo.fromMap(doc.data(), doc.id))
        .toList();
  }
}
