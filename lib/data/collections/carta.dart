import 'package:json_annotation/json_annotation.dart';
import 'enums/card_provider.dart';

part 'carta.g.dart';

@JsonSerializable()
class Carta {
  String id;
  final String userId;
  final String cardHolderName;
  final String cardNumber;
  final int expirationMonth;
  final int expirationYear;
  final String cvv;
  final CardProvider provider;

  Carta({
    required this.id,
    required this.userId,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expirationMonth,
    required this.expirationYear,
    required this.cvv,
    required this.provider,
  });

  factory Carta.fromJson(Map<String, dynamic> json) => _$CartaFromJson(json);
  Map<String, dynamic> toJson() => _$CartaToJson(this);
}
