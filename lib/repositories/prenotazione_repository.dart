import '../data/collections/prenotazione.dart';
import '../data/dao/prenotazione_dao.dart';

class PrenotazioneRepository {
  final PrenotazioneDao _dao = PrenotazioneDao();

  Future<void> creaPrenotazione(Prenotazione p) => _dao.addPrenotazione(p);

  Future<void> aggiornaPrenotazione(Prenotazione p) => _dao.updatePrenotazione(p);

  Future<void> eliminaPrenotazione(String id) => _dao.deletePrenotazione(id);

  Future<List<Prenotazione>> prenotazioniUtente(String userId) => _dao.getPrenotazioniByUser(userId);

  Future<List<Prenotazione>> prenotazioniStruttura(String strutturaId) => _dao.getPrenotazioniByStruttura(strutturaId);

  Future<List<Prenotazione>> prenotazioniCampo(String campoId) => _dao.getPrenotazioniByCampo(campoId);

  Future<Prenotazione?> getById(String id) => _dao.getPrenotazioneById(id);
}
