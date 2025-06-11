class TemplateGiornaliero {
  final int giornoSettimana; 
  final String orarioApertura;
  final String orarioChiusura;

  TemplateGiornaliero({
    required this.giornoSettimana,
    required this.orarioApertura,
    required this.orarioChiusura,
  });

  factory TemplateGiornaliero.fromMap(Map<String, dynamic> map) {
    return TemplateGiornaliero(
      giornoSettimana: map['giornoSettimana'],
      orarioApertura: map['orarioApertura'],
      orarioChiusura: map['orarioChiusura'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'giornoSettimana': giornoSettimana,
      'orarioApertura': orarioApertura,
      'orarioChiusura': orarioChiusura,
    };
  }
}
