import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/prenotazione.dart';

class PrenotazioneDao {
  final CollectionReference prenotazioniCollection =
  FirebaseFirestore.instance.collection('prenotazioni');

  Future<void> addPrenotazione(Prenotazione prenotazione) async {
    final docRef = prenotazioniCollection.doc();
    prenotazione.id = docRef.id;
    await docRef.set(prenotazione.toJson());
  }

  Future<void> updatePrenotazione(Prenotazione prenotazione) async {
    if (prenotazione.id.isEmpty) {
      throw ArgumentError('Prenotazione ID is required for update.');
    }
    await prenotazioniCollection.doc(prenotazione.id).set(prenotazione.toJson());
  }

  Future<void> deletePrenotazione(String id) async {
    await prenotazioniCollection.doc(id).delete();
  }

  Future<List<Prenotazione>> getPrenotazioniByUser(String userId) async {
    final querySnapshot = await prenotazioniCollection
        .where('userId', isEqualTo: userId)
        .get();
    return querySnapshot.docs.map((doc) {
      final pren = Prenotazione.fromJson(doc.data() as Map<String, dynamic>);
      pren.id = doc.id;
      return pren;
    }).toList();
  }

  Future<List<Prenotazione>> getPrenotazioniByCampo(String campoId) async {
    final querySnapshot = await prenotazioniCollection
        .where('campoId', isEqualTo: campoId)
        .get();
    return querySnapshot.docs.map((doc) {
      final pren = Prenotazione.fromJson(doc.data() as Map<String, dynamic>);
      pren.id = doc.id;
      return pren;
    }).toList();
  }

  Future<Prenotazione?> getPrenotazioneById(String id) async {
    final doc = await prenotazioniCollection.doc(id).get();
    if (!doc.exists) return null;
    final pren = Prenotazione.fromJson(doc.data() as Map<String, dynamic>);
    pren.id = doc.id;
    return pren;
  }
}
