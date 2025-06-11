// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'struttura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Struttura _$StrutturaFromJson(Map<String, dynamic> json) => Struttura(
  id: json['id'] as String? ?? '',
  nome: json['nome'] as String,
  indirizzo: json['indirizzo'] as String,
  citta: json['citta'] as String,
  latitudine: (json['latitudine'] as num).toDouble(),
  longitudine: (json['longitudine'] as num).toDouble(),
  sportPraticabili: (json['sportPraticabili'] as List<dynamic>)
      .map((e) => $enumDecode(_$SportEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$StrutturaToJson(Struttura instance) => <String, dynamic>{
  'id': instance.id,
  'nome': instance.nome,
  'indirizzo': instance.indirizzo,
  'citta': instance.citta,
  'latitudine': instance.latitudine,
  'longitudine': instance.longitudine,
  'sportPraticabili': instance.sportPraticabili
      .map((e) => _$SportEnumMap[e]!)
      .toList(),
};

const _$SportEnumMap = {
  Sport.CALCIO5: 'CALCIO5',
  Sport.CALCIO8: 'CALCIO8',
  Sport.TENNIS: 'TENNIS',
  Sport.PADEL: 'PADEL',
  Sport.BEACH_VOLLEY: 'BEACH_VOLLEY',
};
