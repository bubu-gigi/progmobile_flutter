import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';
import 'package:progmobile_flutter/viewmodels/state/giocatore_prenotazioni_state.dart';

class GiocatorePrenotazioniViewModel extends StateNotifier<GiocatorePrenotazioniState> {
  final PrenotazioneRepository _prenRepo;
  final StrutturaRepository _strutturaRepo;
  late String _userId;

  final List<String> opzioniFiltro = ["Tutte", "Attive", "Passate"];

  GiocatorePrenotazioniViewModel(this._prenRepo, this._strutturaRepo)
      : super(GiocatorePrenotazioniState(
          prenotazioni: [],
          strutture: [],
          filtroSelezionato: "Tutte",
          showDialog: false,
        ));

  void init(String userId) async {
    _userId = userId;
    final strutture = await _strutturaRepo.caricaTutte();
    final prenotazioni = await _prenRepo.prenotazioniUtente(userId);
    state = state.copyWith(strutture: strutture, prenotazioni: prenotazioni);
  }

  List<Prenotazione> get prenotazioniFiltrate {
    final oggi = DateTime.now();
    return state.prenotazioni.where((pren) {
      final data = DateFormat("dd/MM/yyyy").parse(pren.data);
      final oraFine = TimeOfDay.fromDateTime(DateFormat.Hm().parse(pren.orarioFine));
      final isPassata = data.isBefore(oggi) || (data.isAtSameMomentAs(oggi) && oraFine.hour < oggi.hour);
      final isAttiva = data.isAfter(oggi) || (data.isAtSameMomentAs(oggi) && oraFine.hour >= oggi.hour);
      return state.filtroSelezionato == "Tutte" ||
          (state.filtroSelezionato == "Passate" && isPassata) ||
          (state.filtroSelezionato == "Attive" && isAttiva);
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
      await _prenRepo.eliminaPrenotazione(pren.id);
      final prenotazioni = await _prenRepo.prenotazioniUtente(_userId);
      state = state.copyWith(
        prenotazioni: prenotazioni,
        showDialog: false,
        prenotazioneDaEliminare: null,
      );
    }
  }
}

final giocatorePrenotazioniViewModelProvider =
    StateNotifierProvider<GiocatorePrenotazioniViewModel, GiocatorePrenotazioniState>((ref) {
  return GiocatorePrenotazioniViewModel(PrenotazioneRepository(), StrutturaRepository());
});
