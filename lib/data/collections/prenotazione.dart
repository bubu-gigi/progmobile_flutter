class Prenotazione {
  String id;
  final String userId;
  final String strutturaId;
  final String campoId;
  final String data;
  final String orarioInizio;
  final String orarioFine;
  final bool pubblica;

  Prenotazione({
    this.id = '',
    required this.userId,
    required this.strutturaId,
    required this.campoId,
    required this.data,
    required this.orarioInizio,
    required this.orarioFine,
    this.pubblica = false,
  });

  factory Prenotazione.fromMap(Map<String, dynamic> map, String id) {
    return Prenotazione(
      id: id,
      userId: map['userId'] ?? '',
      strutturaId: map['strutturaId'] ?? '',
      campoId: map['campoId'] ?? '',
      data: map['data'] ?? '',
      orarioInizio: map['orarioInizio'] ?? '',
      orarioFine: map['orarioFine'] ?? '',
      pubblica: map['pubblica'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'strutturaId': strutturaId,
      'campoId': campoId,
      'data': data,
      'orarioInizio': orarioInizio,
      'orarioFine': orarioFine,
      'pubblica': pubblica,
    };
  }
}
