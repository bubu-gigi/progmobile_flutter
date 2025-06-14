import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';

class GiocatorePrenotazioniState {
  final List<Prenotazione> prenotazioni;
  final List<Struttura> strutture;
  final String filtroSelezionato;
  final bool showDialog;
  final Prenotazione? prenotazioneDaEliminare;

  GiocatorePrenotazioniState({
    required this.prenotazioni,
    required this.strutture,
    required this.filtroSelezionato,
    required this.showDialog,
    this.prenotazioneDaEliminare,
  });

  GiocatorePrenotazioniState copyWith({
    List<Prenotazione>? prenotazioni,
    List<Struttura>? strutture,
    String? filtroSelezionato,
    bool? showDialog,
    Prenotazione? prenotazioneDaEliminare,
  }) {
    return GiocatorePrenotazioniState(
      prenotazioni: prenotazioni ?? this.prenotazioni,
      strutture: strutture ?? this.strutture,
      filtroSelezionato: filtroSelezionato ?? this.filtroSelezionato,
      showDialog: showDialog ?? this.showDialog,
      prenotazioneDaEliminare: prenotazioneDaEliminare,
    );
  }
}