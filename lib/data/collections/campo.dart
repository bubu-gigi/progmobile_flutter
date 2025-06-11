import 'template_giornaliero.dart';
import 'enums/sport.dart';
import 'enums/tipologia_terreno.dart';

class Campo {
  String id;
  final String nomeCampo;
  final Sport sport;
  final TipologiaTerreno tipologiaTerreno;
  final double prezzoOrario;
  final int numeroGiocatori;
  final bool spogliatoi;
  final List<TemplateGiornaliero> disponibilitaSettimanale;

  Campo({
    this.id = '',
    required this.nomeCampo,
    required this.sport,
    this.tipologiaTerreno = TipologiaTerreno.ERBA_SINTETICA,
    this.prezzoOrario = 0.0,
    this.numeroGiocatori = 0,
    this.spogliatoi = false,
    this.disponibilitaSettimanale = const [],
  });

  factory Campo.fromMap(Map<String, dynamic> map, String id) {
    return Campo(
      id: id,
      nomeCampo: map['nomeCampo'] ?? '',
      sport: SportExtension.fromString(map['sport']) ?? Sport.CALCIO5,
      tipologiaTerreno: TipologiaTerrenoExtension.fromString(map['tipologiaTerreno']) ?? TipologiaTerreno.ERBA_SINTETICA,
      prezzoOrario: (map['prezzoOrario'] ?? 0).toDouble(),
      numeroGiocatori: (map['numeroGiocatori'] ?? 0).toInt(),
      spogliatoi: map['spogliatoi'] ?? false,
      disponibilitaSettimanale: (map['disponibilitaSettimanale'] as List<dynamic>? ?? [])
          .map((e) => TemplateGiornaliero.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomeCampo': nomeCampo,
      'sport': sport.name,
      'tipologiaTerreno': tipologiaTerreno.name,
      'prezzoOrario': prezzoOrario,
      'numeroGiocatori': numeroGiocatori,
      'spogliatoi': spogliatoi,
      'disponibilitaSettimanale': disponibilitaSettimanale.map((e) => e.toMap()).toList(),
    };
  }
}
