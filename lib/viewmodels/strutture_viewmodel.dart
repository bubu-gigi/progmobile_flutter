import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers.dart';
import '../data/collections/struttura.dart';
import '../repositories/struttura_repository.dart';
import 'state/strutture_state.dart';

class StruttureViewModel extends Notifier<StruttureState> {
  late final StrutturaRepository _strutturaRepository;

  @override
  StruttureState build() {
    // Avviamo il caricamento iniziale
    _strutturaRepository = ref.read(strutturaRepositoryProvider);
    caricaStrutture();
    return const StruttureState();
  }

  Future<void> caricaStrutture() async {
    state = state.copyWith(isLoading: true);
    final strutture = await _strutturaRepository.caricaTutte();
    state = state.copyWith(strutture: strutture, isLoading: false);
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
}
