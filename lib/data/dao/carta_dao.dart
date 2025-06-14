import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/carta.dart';

class CartaDao {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('carte');

  Future<Carta> createCarta(Carta carta) async {
    final doc = _ref.doc();
    final cartaWithId = carta.copyWith(id: doc.id);
    await doc.set(cartaWithId.toJson());
    return cartaWithId;
  }

  Future<void> updateCarta(Carta carta) async {
    if (carta.id.isEmpty) {
      throw ArgumentError('Carta ID is required for update.');
    }

    final docRef = _ref.doc(carta.id);

    try {
      await docRef.update(carta.toJson());
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw Exception('La carta con ID ${carta.id} non esiste e non può essere aggiornata.');
      } else {
        throw Exception('Errore durante l\'aggiornamento: ${e.message}');
      }
    }
  }

  Future<void> deleteCarta(String id) async {
    final docRef = _ref.doc(id);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception('La carta con ID $id non esiste.');
    }

    await docRef.delete();
  }

  Future<List<Carta>> getCarteByUserId(String userId) async {
    final query = await _ref.where('userId', isEqualTo: userId).get();

    return query.docs.map((doc) {
      return Carta.fromJson(doc.data() as Map<String, dynamic>).copyWith(id: doc.id);
    }).toList();
  }
}
