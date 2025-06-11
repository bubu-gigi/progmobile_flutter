import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections//carta.dart';

class CartaDao {
  final _ref = FirebaseFirestore.instance.collection('carte');

  Future<void> createCarta(Carta carta) async {
    await _ref.doc(carta.id).set(carta.toMap());
  }

  Future<void> updateCarta(Carta carta) async {
    await _ref.doc(carta.id).update(carta.toMap());
  }

  Future<void> deleteCarta(String id) async {
    await _ref.doc(id).delete();
  }

  Future<List<Carta>> getCarteByUserId(String userId) async {
    final query = await _ref.where('userId', isEqualTo: userId).get();
    return query.docs.map((doc) => Carta.fromFirestore(doc.data(), doc.id)).toList();
  }

  Stream<List<Carta>> watchCarteByUserId(String userId) {
    return _ref.where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Carta.fromFirestore(doc.data(), doc.id)).toList();
    });
  }
}
