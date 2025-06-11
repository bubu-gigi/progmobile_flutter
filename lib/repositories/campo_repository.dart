import '../data/collections/campo.dart';
import '../data/dao/campo_dao.dart';

class CampoRepository {
  final CampoDao _dao = CampoDao();

  Future<void> aggiungiCampo(String strutturaId, Campo campo) {
    return _dao.addCampo(strutturaId, campo);
  }

  Future<void> aggiornaCampo(String strutturaId, Campo campo) {
    return _dao.updateCampo(strutturaId, campo);
  }

  Future<void> eliminaCampo(String strutturaId, String campoId) {
    return _dao.deleteCampo(strutturaId, campoId);
  }

  Future<List<Campo>> caricaCampi(String strutturaId) {
    return _dao.getCampi(strutturaId);
  }
}
