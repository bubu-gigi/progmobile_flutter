import 'package:flutter/foundation.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';

class StrutturaDettaglioViewModel extends ChangeNotifier {
  final StrutturaRepository _strutturaRepo = StrutturaRepository();
  final PrenotazioneRepository _prenotazioneRepository = PrenotazioneRepository();
  final CampoRepository _campoRepo = CampoRepository();

  bool isLoading = false;
  Struttura? struttura;
  List<Campo> campi = [];

  StrutturaDettaglioViewModel();

  Future<void> fetchDettagli(String strutturaId) async {
    isLoading = true;
    notifyListeners();

    try {
      struttura = await _strutturaRepo.caricaPerId(strutturaId);
      campi = await _campoRepo.caricaCampi(strutturaId);
    } catch (e) {
      struttura = null;
      campi = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> creaPrenotazione(Prenotazione p) async {
    await _prenotazioneRepository.creaPrenotazione(p);
  }

  Future<void> eliminaPrenotazione(String prenotazioneId) async {
    await _prenotazioneRepository.eliminaPrenotazione(prenotazioneId);
  }
}
