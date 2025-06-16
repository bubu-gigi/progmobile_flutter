import 'package:progmobile_flutter/data/collections/prenotazione.dart';
import 'package:progmobile_flutter/data/collections/struttura.dart';

class AdminPrenotazioniState {
  final List<Prenotazione> prenotazioni;
  final List<Struttura> strutture;
  final String filtroCitta;
  final String filtroSport;

  AdminPrenotazioniState({
    required this.prenotazioni,
    required this.strutture,
    required this.filtroCitta,
    required this.filtroSport,
  });

  factory AdminPrenotazioniState.initial() => AdminPrenotazioniState(
    prenotazioni: [],
    strutture: [],
    filtroCitta: '',
    filtroSport: '',
  );

  AdminPrenotazioniState copyWith({
    List<Prenotazione>? prenotazioni,
    List<Struttura>? strutture,
    String? filtroCitta,
    String? filtroSport,
  }) {
    return AdminPrenotazioniState(
      prenotazioni: prenotazioni ?? this.prenotazioni,
      strutture: strutture ?? this.strutture,
      filtroCitta: filtroCitta ?? this.filtroCitta,
      filtroSport: filtroSport ?? this.filtroSport,
    );
  }
}
