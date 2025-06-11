// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  codiceFiscale: json['codiceFiscale'] as String,
  cognome: json['cognome'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  password: json['password'] as String,
  ruolo: json['ruolo'] as String,
  preferiti: (json['preferiti'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'codiceFiscale': instance.codiceFiscale,
  'cognome': instance.cognome,
  'email': instance.email,
  'name': instance.name,
  'password': instance.password,
  'ruolo': instance.ruolo,
  'preferiti': instance.preferiti,
};
