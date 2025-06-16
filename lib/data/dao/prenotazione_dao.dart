import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/prenotazione.dart';

class PrenotazioneDao {
  final CollectionReference prenotazioniCollection =
      FirebaseFirestore.instance.collection('prenotazioni');

  Future<void> addPrenotazione(Prenotazione prenotazione) async {
    final docRef = prenotazioniCollection.doc();
    final prenotazioneWithId = prenotazione.copyWith(id: docRef.id);
    await docRef.set(prenotazioneWithId.toJson());
  }

  Future<void> updatePrenotazione(Prenotazione prenotazione) async {
    if (prenotazione.id.isEmpty) {
      throw ArgumentError('Prenotazione ID is required for update.');
    }

    final docRef = prenotazioniCollection.doc(prenotazione.id);

    try {
      await docRef.update(prenotazione.toJson());
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw Exception(
            'La prenotazione con ID ${prenotazione.id} non esiste e non può essere aggiornata.');
      } else {
        throw Exception('Errore durante l\'aggiornamento: ${e.message}');
      }
    }
  }

  Future<void> deletePrenotazione(String id) async {
    final docRef = prenotazioniCollection.doc(id);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception('La prenotazione con ID $id non esiste.');
    }

    await docRef.delete();
  }

  Future<List<Prenotazione>> getPrenotazioniByUser(String userId) async {
    final querySnapshot =
        await prenotazioniCollection.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs.map((doc) {
      return Prenotazione.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }).toList();
  }

  Future<List<Prenotazione>> getPrenotazioniByStruttura(String strutturaId) async {
    final querySnapshot = await prenotazioniCollection.where('strutturaId', isEqualTo: strutturaId).get();

    return querySnapshot.docs.map((doc) {
      return Prenotazione.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }).toList();
  }

  Future<List<Prenotazione>> getPrenotazioniByCampo(String campoId) async {
    final querySnapshot =
        await prenotazioniCollection.where('campoId', isEqualTo: campoId).get();

    return querySnapshot.docs.map((doc) {
      return Prenotazione.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }).toList();
  }

  Future<Prenotazione?> getPrenotazioneById(String id) async {
    final doc = await prenotazioniCollection.doc(id).get();

    if (!doc.exists) return null;

    return Prenotazione.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }
}
