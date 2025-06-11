// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prenotazione.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prenotazione _$PrenotazioneFromJson(Map<String, dynamic> json) => Prenotazione(
  id: json['id'] as String? ?? '',
  userId: json['userId'] as String,
  strutturaId: json['strutturaId'] as String,
  campoId: json['campoId'] as String,
  data: json['data'] as String,
  orarioInizio: json['orarioInizio'] as String,
  orarioFine: json['orarioFine'] as String,
  pubblica: json['pubblica'] as bool? ?? false,
);

Map<String, dynamic> _$PrenotazioneToJson(Prenotazione instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'strutturaId': instance.strutturaId,
      'campoId': instance.campoId,
      'data': instance.data,
      'orarioInizio': instance.orarioInizio,
      'orarioFine': instance.orarioFine,
      'pubblica': instance.pubblica,
    };
