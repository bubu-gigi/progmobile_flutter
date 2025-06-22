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

  Future<void> aggiungiStruttura(Struttura struttura) async {
    await _strutturaRepository.salvaStruttura(struttura);
    await caricaStrutture();
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
}
