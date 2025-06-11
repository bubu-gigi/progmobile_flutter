// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartaImpl _$$CartaImplFromJson(Map<String, dynamic> json) => _$CartaImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  cardHolderName: json['cardHolderName'] as String,
  cardNumber: json['cardNumber'] as String,
  expirationMonth: (json['expirationMonth'] as num).toInt(),
  expirationYear: (json['expirationYear'] as num).toInt(),
  cvv: json['cvv'] as String,
  provider: $enumDecode(_$CardProviderEnumMap, json['provider']),
);

Map<String, dynamic> _$$CartaImplToJson(_$CartaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cardHolderName': instance.cardHolderName,
      'cardNumber': instance.cardNumber,
      'expirationMonth': instance.expirationMonth,
      'expirationYear': instance.expirationYear,
      'cvv': instance.cvv,
      'provider': _$CardProviderEnumMap[instance.provider]!,
    };

const _$CardProviderEnumMap = {
  CardProvider.VISA: 'VISA',
  CardProvider.MASTERCARD: 'MASTERCARD',
  CardProvider.AMEX: 'AMEX',
};
