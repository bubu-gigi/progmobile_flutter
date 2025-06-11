import 'package:json_annotation/json_annotation.dart';

part 'prenotazione.g.dart';

@JsonSerializable()
class Prenotazione {
  String id;
  final String userId;
  final String strutturaId;
  final String campoId;
  final String data;
  final String orarioInizio;
  final String orarioFine;
  final bool pubblica;

  Prenotazione({
    this.id = '',
    required this.userId,
    required this.strutturaId,
    required this.campoId,
    required this.data,
    required this.orarioInizio,
    required this.orarioFine,
    this.pubblica = false,
  });

  factory Prenotazione.fromJson(Map<String, dynamic> json) => _$PrenotazioneFromJson(json);
  Map<String, dynamic> toJson() => _$PrenotazioneToJson(this);
}
