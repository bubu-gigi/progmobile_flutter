import 'package:progmobile_flutter/data/collections/campo.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';

class StrutturaDettaglioState {
  final Struttura? struttura;
  final List<Campo> campi;
  final bool isLoading;

  const StrutturaDettaglioState({
    required this.struttura,
    required this.campi,
    required this.isLoading,
  });

  factory StrutturaDettaglioState.initial() => const StrutturaDettaglioState(
    struttura: null,
    campi: [],
    isLoading: true,
  );
}
