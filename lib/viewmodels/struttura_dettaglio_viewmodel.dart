import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';
import 'package:progmobile_flutter/viewmodels/state/struttura_dettaglio_state.dart';
import '../core/providers.dart';

class StrutturaDettaglioViewModel extends Notifier<StrutturaDettaglioState> {
  late final StrutturaRepository strutturaRepo;
  late final PrenotazioneRepository prenotazioneRepository;
  late final CampoRepository campoRepo;

  @override
  StrutturaDettaglioState build() {
    strutturaRepo = ref.read(strutturaRepositoryProvider);
    prenotazioneRepository = ref.read(prenotazioneRepositoryProvider);
    campoRepo = ref.read(campoRepositoryProvider);
    return StrutturaDettaglioState.initial();
  }

  Future<void> fetchDettagli(String strutturaId) async {
    state = StrutturaDettaglioState.initial();
    try {
      final struttura = await strutturaRepo.caricaPerId(strutturaId);
      final campi = await campoRepo.caricaCampi(strutturaId);
      state = StrutturaDettaglioState(
        struttura: struttura,
        campi: campi,
        isLoading: false,
      );
    } catch (e) {
      state = StrutturaDettaglioState(
        struttura: null,
        campi: [],
        isLoading: false,
      );
    }
  }

  Future<void> creaPrenotazione(Prenotazione p) async {
    await prenotazioneRepository.creaPrenotazione(p);
  }

  Future<void> eliminaPrenotazione(String prenotazioneId) async {
    await prenotazioneRepository.eliminaPrenotazione(prenotazioneId);
  }
}
