import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/carta.dart';

class CartaDao {
  final _ref = FirebaseFirestore.instance.collection('carte');

  Future<void> createCarta(Carta carta) async {
    final doc = _ref.doc();
    carta.id = doc.id;
    await doc.set(carta.toJson());
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
      final carta = Carta.fromJson(doc.data());
      carta.id = doc.id;
      return carta;
    }).toList();
  }

  Stream<List<Carta>> watchCarteByUserId(String userId) {
    return _ref.where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final carta = Carta.fromJson(doc.data());
        carta.id = doc.id;
        return carta;
      }).toList();
    });
  }
}
