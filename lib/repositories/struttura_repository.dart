import '../data/collections/struttura.dart';
import '../data/dao/struttura_dao.dart';

class StrutturaRepository {
  final StrutturaDao _dao = StrutturaDao();

  Future<void> salvaStruttura(Struttura struttura) {
    return _dao.addStruttura(struttura);
  }

  Future<void> aggiornaStruttura(Struttura struttura) {
    return _dao.updateStruttura(struttura);
  }

  Future<void> eliminaStruttura(String id) {
    return _dao.deleteStruttura(id);
  }

  Future<List<Struttura>> caricaTutte() {
    return _dao.getStrutture();
  }

  Future<Struttura?> caricaPerId(String id) {
    return _dao.getStrutturaById(id);
  }
}
