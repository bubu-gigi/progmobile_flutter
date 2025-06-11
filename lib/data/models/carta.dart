enum CardProvider { VISA, MASTERCARD, AMEX }

class Carta {
  final String id;
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

  factory Carta.fromFirestore(Map<String, dynamic> data, String id) {
    return Carta(
      id: id,
      userId: data['userId'] ?? '',
      cardHolderName: data['cardHolderName'] ?? '',
      cardNumber: data['cardNumber'] ?? '',
      expirationMonth: data['expirationMonth'] ?? 1,
      expirationYear: data['expirationYear'] ?? 2025,
      cvv: data['cvv'] ?? '',
      provider: _parseProvider(data['provider']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expirationMonth': expirationMonth,
      'expirationYear': expirationYear,
      'cvv': cvv,
      'provider': provider.name,
    };
  }

  static CardProvider _parseProvider(String? raw) {
    switch (raw) {
      case 'MASTERCARD':
        return CardProvider.MASTERCARD;
      case 'AMEX':
        return CardProvider.AMEX;
      default:
        return CardProvider.VISA;
    }
  }
}
