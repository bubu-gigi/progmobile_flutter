import 'package:flutter/foundation.dart';
import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import 'package:progmobile_flutter/repositories/prenotazione_repository.dart';
import 'package:progmobile_flutter/repositories/struttura_repository.dart';
import 'package:progmobile_flutter/repositories/user_repository.dart';

import '../core/user_session.dart';

class StrutturaDettaglioViewModel extends ChangeNotifier {
  final StrutturaRepository _strutturaRepo = StrutturaRepository();
  final PrenotazioneRepository _prenotazioneRepository = PrenotazioneRepository();
  final CampoRepository _campoRepo = CampoRepository();
  final UserRepository _userRepository = UserRepository();

  bool isLoading = false;
  Struttura? struttura;
  List<Campo> campi = [];
  List<Prenotazione> prenotazioni = [];

  StrutturaDettaglioViewModel();

  Future<void> fetchDettagli(String strutturaId) async {
    isLoading = true;
    notifyListeners();

    try {
      struttura = await _strutturaRepo.caricaPerId(strutturaId);
      campi = await _campoRepo.caricaCampi(strutturaId);
      prenotazioni = await _prenotazioneRepository.prenotazioniStruttura(strutturaId);
    } catch (e) {
      struttura = null;
      campi = [];
      prenotazioni = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> creaPrenotazione(Prenotazione p) async {
    await _prenotazioneRepository.creaPrenotazione(p);
    prenotazioni.add(p);
    notifyListeners();
  }

  Future<void> eliminaPrenotazione(String prenotazioneId) async {
    await _prenotazioneRepository.eliminaPrenotazione(prenotazioneId);
    prenotazioni.removeWhere((p) => p.id == prenotazioneId);
    notifyListeners();
  }

  Future<void> togglePreferito(String strutturaId) async {
    final user = UserSessionManager().getCurrentUser();
    if (user == null) return;

    final preferiti = List<String>.from(user.preferiti);

    if (preferiti.contains(strutturaId)) {
      preferiti.remove(strutturaId);
    } else {
      preferiti.add(strutturaId);
    }

    final updatedUser = user.copyWith(preferiti: preferiti);

    await _userRepository.updateUser(updatedUser);
    UserSessionManager().setCurrentUser(updatedUser);
    notifyListeners();
  }


}

