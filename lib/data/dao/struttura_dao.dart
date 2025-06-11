import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/struttura.dart';

class StrutturaDao {
  final CollectionReference struttureRef =
  FirebaseFirestore.instance.collection('strutture');

  Future<void> addStruttura(Struttura struttura) async {
    final docRef = struttureRef.doc();
    struttura.id = docRef.id;
    await docRef.set(struttura.toJson());
  }

  Future<void> updateStruttura(Struttura struttura) async {
    if (struttura.id.isEmpty) {
      throw ArgumentError('Struttura ID is required for update.');
    }
    final docRef = struttureRef.doc(struttura.id);
    await docRef.set(struttura.toJson());
  }

  Future<void> deleteStruttura(String id) async {
    await struttureRef.doc(id).delete();
  }

  Future<List<Struttura>> getStrutture() async {
    final snapshot = await struttureRef.get();
    return snapshot.docs.map((doc) {
      final struttura = Struttura.fromJson(doc.data() as Map<String, dynamic>);
      struttura.id = doc.id;
      return struttura;
    }).toList();
  }

  Future<Struttura?> getStrutturaById(String id) async {
    final doc = await struttureRef.doc(id).get();
    if (!doc.exists) return null;
    final struttura = Struttura.fromJson(doc.data() as Map<String, dynamic>);
    struttura.id = doc.id;
    return struttura;
  }
}
