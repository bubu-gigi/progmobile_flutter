import 'package:cloud_firestore/cloud_firestore.dart';
import './enums/sport.dart';

class Struttura {
  final String id;
  final String nome;
  final String indirizzo;
  final String citta;
  final double latitudine;
  final double longitudine;
  final List<Sport> sportPraticabili;

  Struttura({
    this.id = '',
    required this.nome,
    required this.indirizzo,
    required this.citta,
    required this.latitudine,
    required this.longitudine,
    required this.sportPraticabili,
  });

  factory Struttura.fromMap(Map<String, dynamic> map, String id) {
    return Struttura(
      id: id,
      nome: map['nome'] ?? '',
      indirizzo: map['indirizzo'] ?? '',
      citta: map['citta'] ?? '',
      latitudine: (map['latitudine'] ?? 0).toDouble(),
      longitudine: (map['longitudine'] ?? 0).toDouble(),
      sportPraticabili: (map['sportPraticabili'] as List<dynamic>?)
          ?.map((e) => SportExtension.fromString(e))
          .whereType<Sport>()
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'indirizzo': indirizzo,
      'citta': citta,
      'latitudine': latitudine,
      'longitudine': longitudine,
      'sportPraticabili': sportPraticabili.map((e) => e.name).toList(),
    };
  }
}
