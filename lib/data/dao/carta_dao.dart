import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/carta.dart';

class CartaDao {
  final _ref = FirebaseFirestore.instance.collection('carte');

  Future<void> createCarta(Carta carta) async {
    final doc = _ref.doc();
    final cartaWithId = carta.copyWith(id: doc.id);
    await doc.set(cartaWithId.toJson());
  }

  Future<void> updateCarta(Carta carta) async {
    if (carta.id.isEmpty) {
      throw ArgumentError('Carta ID is required for update.');
    }
    await _ref.doc(carta.id).update(carta.toJson());
  }

  Future<void> deleteCarta(String id) async {
    await _ref.doc(id).delete();
  }

  Future<List<Carta>> getCarteByUserId(String userId) async {
    final query = await _ref.where('userId', isEqualTo: userId).get();
    return query.docs.map((doc) {
      return Carta.fromJson(doc.data()).copyWith(id: doc.id);
    }).toList();
  }

  Stream<List<Carta>> watchCarteByUserId(String userId) {
    return _ref.where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Carta.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }
}
