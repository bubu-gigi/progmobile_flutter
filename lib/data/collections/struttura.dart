import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:progmobile_flutter/data/collections/enums/sport.dart';

part 'struttura.freezed.dart';
part 'struttura.g.dart';

@freezed
class Struttura with _$Struttura {
  const factory Struttura({
    @Default('') String id,
    required String nome,
    required String indirizzo,
    required String citta,
    required double latitudine,
    required double longitudine,
    required List<Sport> sportPraticabili,
  }) = _Struttura;

  factory Struttura.fromJson(Map<String, dynamic> json) =>
      _$StrutturaFromJson(json);
}
