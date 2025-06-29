import 'package:flutter/foundation.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';

class GiocatorePrenotazioniViewModel extends ChangeNotifier {
  final PrenotazioneRepository _prenRepo;
  final StrutturaRepository _strutturaRepo;

  GiocatorePrenotazioniViewModel({
    PrenotazioneRepository? prenRepo,
    StrutturaRepository? strutturaRepo,
  })  : _prenRepo = prenRepo ?? PrenotazioneRepository(),
        _strutturaRepo = strutturaRepo ?? StrutturaRepository();

  List<Prenotazione> prenotazioni = [];
  List<Struttura> strutture = [];
  String filtroSelezionato = "Tutte";
  bool showDialog = false;
  Prenotazione? prenotazioneDaEliminare;

  String? _userId;

  final List<String> opzioniFiltro = ["Tutte", "Attive", "Passate"];

  Future<void> init(String userId) async {
    _userId = userId;
    try {
      strutture = await _strutturaRepo.caricaTutte();
      prenotazioni = await _prenRepo.prenotazioniUtente(userId);
      notifyListeners();
    } catch (e) {
      debugPrint('Errore init(): $e');
    }
  }

  List<Prenotazione> get prenotazioniFiltrate {
    final now = DateTime.now();
    return prenotazioni.where((pren) {
      try {
        final dataParts = pren.data.split('/');
        if (dataParts.length != 3) return false;

        final giorno = int.parse(dataParts[0]);
        final mese = int.parse(dataParts[1]);
        final anno = int.parse(dataParts[2]);

        final orarioParts = pren.orarioFine.split(':');
        if (orarioParts.length != 2) return false;

        final oraFine = int.parse(orarioParts[0]);
        final minutiFine = int.parse(orarioParts[1]);
        final fine = DateTime(anno, mese, giorno, oraFine, minutiFine);

        final isPassata = fine.isBefore(now);
        final isAttiva = fine.isAfter(now) || fine.isAtSameMomentAs(now);

        return filtroSelezionato == "Tutte" ||
            (filtroSelezionato == "Passate" && isPassata) ||
            (filtroSelezionato == "Attive" && isAttiva);
      } catch (e) {
        debugPrint('Errore parsing prenotazione: $e');
        return false;
      }
    }).toList();
  }

  void setFiltro(String filtro) {
    filtroSelezionato = filtro;
    notifyListeners();
  }

  void confermaEliminazionePrenotazione(Prenotazione pren) {
    prenotazioneDaEliminare = pren;
    showDialog = true;
    notifyListeners();
  }

  void annullaDialog() {
    showDialog = false;
    prenotazioneDaEliminare = null;
    notifyListeners();
  }

  Future<void> eliminaPrenotazione() async {
    if (prenotazioneDaEliminare == null) return;
    try {
      await _prenRepo.eliminaPrenotazione(prenotazioneDaEliminare!.id);
      prenotazioni = await _prenRepo.prenotazioniUtente(_userId!);
      showDialog = false;
      prenotazioneDaEliminare = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Errore eliminazione: $e');
    }
  }
}
