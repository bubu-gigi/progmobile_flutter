import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums/card_provider.dart';

part 'carta.freezed.dart';
part 'carta.g.dart';

@freezed
class Carta with _$Carta {
  const factory Carta({
    required String id,
    required String userId,
    required String cardHolderName,
    required String cardNumber,
    required int expirationMonth,
    required int expirationYear,
    required String cvv,
    required CardProvider provider,
  }) = _Carta;

  factory Carta.fromJson(Map<String, dynamic> json) => _$CartaFromJson(json);
}
