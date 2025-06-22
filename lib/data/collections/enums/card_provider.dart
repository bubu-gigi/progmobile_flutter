import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum CardProvider {
  VISA,
  MASTERCARD,
  AMEX,
}

extension CardProviderExtension on CardProvider {
  String get label {
    switch (this) {
      case CardProvider.VISA:
        return 'Visa';
      case CardProvider.MASTERCARD:
        return 'Mastercard';
      case CardProvider.AMEX:
        return 'American Express';
    }
  }
}
