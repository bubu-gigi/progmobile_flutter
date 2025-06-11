// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_giornaliero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateGiornaliero _$TemplateGiornalieroFromJson(Map<String, dynamic> json) =>
    TemplateGiornaliero(
      giornoSettimana: (json['giornoSettimana'] as num).toInt(),
      orarioApertura: json['orarioApertura'] as String,
      orarioChiusura: json['orarioChiusura'] as String,
    );

Map<String, dynamic> _$TemplateGiornalieroToJson(
  TemplateGiornaliero instance,
) => <String, dynamic>{
  'giornoSettimana': instance.giornoSettimana,
  'orarioApertura': instance.orarioApertura,
  'orarioChiusura': instance.orarioChiusura,
};
