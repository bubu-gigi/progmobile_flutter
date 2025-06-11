// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_giornaliero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TemplateGiornalieroImpl _$$TemplateGiornalieroImplFromJson(
  Map<String, dynamic> json,
) => _$TemplateGiornalieroImpl(
  giornoSettimana: (json['giornoSettimana'] as num).toInt(),
  orarioApertura: json['orarioApertura'] as String,
  orarioChiusura: json['orarioChiusura'] as String,
);

Map<String, dynamic> _$$TemplateGiornalieroImplToJson(
  _$TemplateGiornalieroImpl instance,
) => <String, dynamic>{
  'giornoSettimana': instance.giornoSettimana,
  'orarioApertura': instance.orarioApertura,
  'orarioChiusura': instance.orarioChiusura,
};
