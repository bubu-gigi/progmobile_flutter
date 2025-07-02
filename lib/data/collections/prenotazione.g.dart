// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prenotazione.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrenotazioneImpl _$$PrenotazioneImplFromJson(Map<String, dynamic> json) =>
    _$PrenotazioneImpl(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String,
      strutturaId: json['strutturaId'] as String,
      campoId: json['campoId'] as String,
      data: json['data'] as String,
      orarioInizio: json['orarioInizio'] as String,
      orarioFine: json['orarioFine'] as String,
      campoNome: json['campoNome'] as String,
      strutturaNome: json['strutturaNome'] as String,
      pubblica: json['pubblica'] as bool? ?? false,
    );

Map<String, dynamic> _$$PrenotazioneImplToJson(_$PrenotazioneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'strutturaId': instance.strutturaId,
      'campoId': instance.campoId,
      'data': instance.data,
      'orarioInizio': instance.orarioInizio,
      'orarioFine': instance.orarioFine,
      'campoNome': instance.campoNome,
      'strutturaNome': instance.strutturaNome,
      'pubblica': instance.pubblica,
    };
