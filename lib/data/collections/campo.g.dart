// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campo _$CampoFromJson(Map<String, dynamic> json) => Campo(
  id: json['id'] as String? ?? '',
  nomeCampo: json['nomeCampo'] as String,
  sport: $enumDecode(_$SportEnumMap, json['sport']),
  tipologiaTerreno:
      $enumDecodeNullable(
        _$TipologiaTerrenoEnumMap,
        json['tipologiaTerreno'],
      ) ??
      TipologiaTerreno.ERBA_SINTETICA,
  prezzoOrario: (json['prezzoOrario'] as num?)?.toDouble() ?? 0.0,
  numeroGiocatori: (json['numeroGiocatori'] as num?)?.toInt() ?? 0,
  spogliatoi: json['spogliatoi'] as bool? ?? false,
  disponibilitaSettimanale:
      (json['disponibilitaSettimanale'] as List<dynamic>?)
          ?.map((e) => TemplateGiornaliero.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CampoToJson(Campo instance) => <String, dynamic>{
  'id': instance.id,
  'nomeCampo': instance.nomeCampo,
  'sport': _$SportEnumMap[instance.sport]!,
  'tipologiaTerreno': _$TipologiaTerrenoEnumMap[instance.tipologiaTerreno]!,
  'prezzoOrario': instance.prezzoOrario,
  'numeroGiocatori': instance.numeroGiocatori,
  'spogliatoi': instance.spogliatoi,
  'disponibilitaSettimanale': instance.disponibilitaSettimanale
      .map((e) => e.toJson())
      .toList(),
};

const _$SportEnumMap = {
  Sport.CALCIO5: 'CALCIO5',
  Sport.CALCIO8: 'CALCIO8',
  Sport.TENNIS: 'TENNIS',
  Sport.PADEL: 'PADEL',
  Sport.BEACH_VOLLEY: 'BEACH_VOLLEY',
};

const _$TipologiaTerrenoEnumMap = {
  TipologiaTerreno.ERBA_SINTETICA: 'ERBA_SINTETICA',
  TipologiaTerreno.CEMENTO: 'CEMENTO',
};
