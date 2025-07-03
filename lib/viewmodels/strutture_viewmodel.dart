import 'package:flutter/foundation.dart';
import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/repositories/campo_repository.dart';
import '../data/collections/struttura.dart';
import '../repositories/struttura_repository.dart';

class StruttureViewModel extends ChangeNotifier {
  final StrutturaRepository _strutturaRepository;
  final CampoRepository _campoRepository;

  List<Struttura> strutture = [];
  List<Campo> strutturaDettaglioCampi = [];
  bool isLoading = false;

  StruttureViewModel(this._strutturaRepository, this._campoRepository) {
    caricaStrutture();
  }

  Future<void> caricaStrutture() async {
    isLoading = true;
    notifyListeners();

    strutture = await _strutturaRepository.caricaTutte();

    isLoading = false;
    notifyListeners();
  }

  Future<Struttura> aggiungiStruttura(Struttura struttura) async {
    final nuova = await _strutturaRepository.salvaStruttura(struttura);
    await caricaStrutture();
    return nuova;
  }


  Future<void> aggiornaStruttura(Struttura struttura) async {
    await _strutturaRepository.aggiornaStruttura(struttura);
    await caricaStrutture();
  }

  Future<void> eliminaStruttura(String id) async {
    await _strutturaRepository.eliminaStruttura(id);
    await caricaStrutture();
  }

  Future<void> caricaCampi(String strutturaId) async {
    final campi = await _campoRepository.caricaCampi(strutturaId);
    strutturaDettaglioCampi = campi;
  }

  Future<void> salvaCampo(String strutturaId, Campo campo) async {
    final campi = await _campoRepository.caricaCampi(strutturaId);
    final esiste = campi.any((c) => c.id == campo.id);

    if (!esiste) {
      await _campoRepository.aggiungiCampo(strutturaId, campo);
    } else {
      await _campoRepository.aggiornaCampo(strutturaId, campo);
    }
  }


  Future<void> sincronizzaCampi(String strutturaId, List<Campo> nuoviCampi) async {
    final campiEsistenti = await _campoRepository.caricaCampi(strutturaId);

    for (final campo in nuoviCampi) {
      await salvaCampo(strutturaId, campo);
    }

    for (final campoEsistente in campiEsistenti) {
      final ancoraPresente = nuoviCampi.any((c) => c.id == campoEsistente.id);
      if (!ancoraPresente) {
        await _campoRepository.eliminaCampo(strutturaId, campoEsistente.id);
      }
    }
  }

}
