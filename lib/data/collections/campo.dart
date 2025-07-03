import 'package:freezed_annotation/freezed_annotation.dart';
import 'template_giornaliero.dart';
import 'enums/sport.dart';
import 'enums/tipologia_terreno.dart';

part 'campo.freezed.dart';
part 'campo.g.dart';

@freezed
class Campo with _$Campo {
  const factory Campo({
    @Default('') String id,
    required String nomeCampo,
    required Sport sport,
    @Default(TipologiaTerreno.ERBA_SINTETICA) TipologiaTerreno tipologiaTerreno,
    @Default(0.0) double prezzoOrario,
    @Default(0) int numeroGiocatori,
    @Default(false) bool spogliatoi,
    @Default([]) List<TemplateGiornaliero> disponibilitaSettimanale,
  }) = _Campo;

  factory Campo.fromJson(Map<String, dynamic> json) => _$CampoFromJson(json);
}

extension CampoManualSerialization on Campo {
  Map<String, dynamic> toManualJson() {
    return {
      'id': id,
      'nomeCampo': nomeCampo,
      'sport': sport.name,
      'tipologiaTerreno': tipologiaTerreno.name,
      'prezzoOrario': prezzoOrario,
      'numeroGiocatori': numeroGiocatori,
      'spogliatoi': spogliatoi,
      'disponibilitaSettimanale': disponibilitaSettimanale.map((orario) {
        return {
          'giornoSettimana': orario.giornoSettimana,
          'orarioApertura': orario.orarioApertura,
          'orarioChiusura': orario.orarioChiusura,
        };
      }).toList(),
    };
  }
}