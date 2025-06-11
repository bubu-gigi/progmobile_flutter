import 'package:json_annotation/json_annotation.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';

part 'struttura.g.dart';

@JsonSerializable()
class Struttura {
  String id;
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

  factory Struttura.fromJson(Map<String, dynamic> json) => _$StrutturaFromJson(json);
  Map<String, dynamic> toJson() => _$StrutturaToJson(this);
}
