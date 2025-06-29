import 'package:flutter/foundation.dart';
import '../data/collections/prenotazione.dart';
import '../data/collections/struttura.dart';
import '../repositories/prenotazione_repository.dart';
import '../repositories/struttura_repository.dart';

class AdminPrenotazioniViewModel extends ChangeNotifier {
  final PrenotazioneRepository _prenRepo;
  final StrutturaRepository _strutturaRepo;

  List<Prenotazione> prenotazioni = [];
  List<Struttura> strutture = [];
  String filtroCitta = '';
  String filtroSport = '';

  AdminPrenotazioniViewModel(this._prenRepo, this._strutturaRepo) {
    _caricaDati();
  }

  Future<void> _caricaDati() async {
    try {
      strutture = await _strutturaRepo.caricaTutte();
      prenotazioni.clear();

      for (final s in strutture) {
        final pren = await _prenRepo.prenotazioniStruttura(s.id);
        prenotazioni.addAll(pren);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Errore nel caricamento dati: $e');
    }
  }

  void aggiornaFiltroCitta(String val) {
    filtroCitta = val;
    notifyListeners();
  }

  void aggiornaFiltroSport(String val) {
    filtroSport = val;
    notifyListeners();
  }

  List<Struttura> get struttureFiltrate {
    return strutture.where((s) {
      final cittaMatch = filtroCitta.isEmpty ||
          s.citta.toLowerCase().contains(filtroCitta.toLowerCase());

      final sportMatch = filtroSport.isEmpty ||
          s.sportPraticabili.any(
                (sp) => sp.name.toLowerCase().contains(filtroSport.toLowerCase()),
          );

      return cittaMatch && sportMatch;
    }).toList();
  }

  List<Prenotazione> prenotazioniStruttura(String strutturaId) {
    return prenotazioni.where((p) => p.strutturaId == strutturaId).toList();
  }
}
