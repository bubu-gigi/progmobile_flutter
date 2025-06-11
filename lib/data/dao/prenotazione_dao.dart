import 'package:cloud_firestore/cloud_firestore.dart';
import '../collections/prenotazione.dart';

class PrenotazioneDao {
  final CollectionReference prenotazioniCollection =
  FirebaseFirestore.instance.collection('prenotazioni');

  Future<void> addPrenotazione(Prenotazione prenotazione) async {
    final docRef = prenotazioniCollection.doc();
    prenotazione.id = docRef.id;
    await docRef.set(prenotazione.toMap());
  }

  Future<void> updatePrenotazione(Prenotazione prenotazione) async {
    await prenotazioniCollection.doc(prenotazione.id).set(prenotazione.toMap());
  }

  Future<void> deletePrenotazione(String id) async {
    await prenotazioniCollection.doc(id).delete();
  }

  Future<List<Prenotazione>> getPrenotazioniByUser(String userId) async {
    final querySnapshot = await prenotazioniCollection
        .where('userId', isEqualTo: userId)
        .get();
    return querySnapshot.docs
        .map((doc) => Prenotazione.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<List<Prenotazione>> getPrenotazioniByCampo(String campoId) async {
    final querySnapshot = await prenotazioniCollection
        .where('campoId', isEqualTo: campoId)
        .get();
    return querySnapshot.docs
        .map((doc) => Prenotazione.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<Prenotazione?> getPrenotazioneById(String id) async {
    final doc = await prenotazioniCollection.doc(id).get();
    if (!doc.exists) return null;
    return Prenotazione.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
