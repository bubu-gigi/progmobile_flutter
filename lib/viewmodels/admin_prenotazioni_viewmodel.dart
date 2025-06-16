
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/viewmodels/state/admin_prenotazioni_state.dart';

import '../core/providers.dart';
import '../repositories/prenotazione_repository.dart';
import '../repositories/struttura_repository.dart';

class AdminPrenotazioniViewModel extends Notifier<AdminPrenotazioniState> {
  late final PrenotazioneRepository _prenRepo;
  late final StrutturaRepository _strutturaRepo;

  @override
  AdminPrenotazioniState build() {
    _prenRepo = ref.read(prenotazioneRepositoryProvider);
    _strutturaRepo = ref.read(strutturaRepositoryProvider);
    _caricaDati();
    return AdminPrenotazioniState.initial();
  }

  Future<void> _caricaDati() async {
    try {
      final strutture = await _strutturaRepo.caricaTutte();
      final prenotazioni = <Prenotazione>[];
      for (final s in strutture) {
        final pren = await _prenRepo.prenotazioniStruttura(s.id);
        prenotazioni.addAll(pren);
      }
      state = state.copyWith(prenotazioni: prenotazioni, strutture: strutture);
    } catch (e) {

    }
  }

  void aggiornaFiltroCitta(String val) {
    state = state.copyWith(filtroCitta: val);
  }

  void aggiornaFiltroSport(String val) {
    state = state.copyWith(filtroSport: val);
  }

  List<Struttura> get struttureFiltrate {
    return state.strutture.where((s) {
      final cittaMatch = state.filtroCitta.isEmpty || s.citta.toLowerCase().contains(state.filtroCitta.toLowerCase());
      final sportMatch = state.filtroSport.isEmpty ||
          s.sportPraticabili.any(
                (sp) => sp.name.toLowerCase().contains(state.filtroSport.toLowerCase()),
          );
      return cittaMatch && sportMatch;
    }).toList();
  }

  List<Prenotazione> prenotazioniStruttura(String strutturaId) {
    return state.prenotazioni.where((p) => p.strutturaId == strutturaId).toList();
  }
}
