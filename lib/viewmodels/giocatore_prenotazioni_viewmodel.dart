import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';
import 'package:progmobile_flutter/viewmodels/state/giocatore_prenotazioni_state.dart';

class GiocatorePrenotazioniViewModel extends Notifier<GiocatorePrenotazioniState> {
  late final PrenotazioneRepository _prenRepo;
  late final StrutturaRepository _strutturaRepo;
  late String _userId;

  final List<String> opzioniFiltro = ["Tutte", "Attive", "Passate"];

  @override
  GiocatorePrenotazioniState build() {
    _prenRepo = PrenotazioneRepository();
    _strutturaRepo = StrutturaRepository();

    return GiocatorePrenotazioniState(
      prenotazioni: [],
      strutture: [],
      filtroSelezionato: "Tutte",
      showDialog: false,
    );
  }

  Future<void> init(String userId) async {
    _userId = userId;
    try {
      final strutture = await _strutturaRepo.caricaTutte();
      final prenotazioni = await _prenRepo.prenotazioniUtente(userId);
      state = state.copyWith(strutture: strutture, prenotazioni: prenotazioni);
    } catch (e) {
      debugPrint("Errore in init(): $e");
    }
  }

  List<Prenotazione> get prenotazioniFiltrate {
    final now = DateTime.now();

    return state.prenotazioni.where((pren) {
      try {
        final dataStr = pren.data;
        final fineStr = pren.orarioFine;

        // Log di debug
        debugPrint("Parsing prenotazione → data: $dataStr, orarioFine: $fineStr");

        // Parsing data
        final dataParts = dataStr.split("/");
        if (dataParts.length != 3) return false;

        final giorno = int.parse(dataParts[0]);
        final mese = int.parse(dataParts[1]);
        final anno = int.parse(dataParts[2]);

        // Parsing orario
        final orarioParts = fineStr.split(":");
        if (orarioParts.length != 2) return false;

        final oraFine = int.parse(orarioParts[0]);
        final minutiFine = int.parse(orarioParts[1]);

        final fine = DateTime(anno, mese, giorno, oraFine, minutiFine);

        final isPassata = fine.isBefore(now);
        final isAttiva = fine.isAfter(now) || fine.isAtSameMomentAs(now);

        return state.filtroSelezionato == "Tutte" ||
            (state.filtroSelezionato == "Passate" && isPassata) ||
            (state.filtroSelezionato == "Attive" && isAttiva);
      } catch (e) {
        debugPrint("Errore parsing prenotazione: $e");
        return false;
      }
    }).toList();
  }


  void setFiltro(String filtro) {
    state = state.copyWith(filtroSelezionato: filtro);
  }

  void confermaEliminazionePrenotazione(Prenotazione pren) {
    state = state.copyWith(
      prenotazioneDaEliminare: pren,
      showDialog: true,
    );
  }

  void annullaDialog() {
    state = state.copyWith(
      showDialog: false,
      prenotazioneDaEliminare: null,
    );
  }

  Future<void> eliminaPrenotazione() async {
    final pren = state.prenotazioneDaEliminare;
    if (pren != null) {
      try {
        await _prenRepo.eliminaPrenotazione(pren.id);
        final prenotazioni = await _prenRepo.prenotazioniUtente(_userId);
        state = state.copyWith(
          prenotazioni: prenotazioni,
          showDialog: false,
          prenotazioneDaEliminare: null,
        );
      } catch (e) {
        debugPrint("Errore eliminazione: $e");
      }
    }
  }
}
