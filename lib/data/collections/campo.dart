import 'package:json_annotation/json_annotation.dart';
import 'template_giornaliero.dart';
import 'enums/sport.dart';
import 'enums/tipologia_terreno.dart';

part 'campo.g.dart';

@JsonSerializable(explicitToJson: true)
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

  factory Campo.fromJson(Map<String, dynamic> json) => _$CampoFromJson(json);
  Map<String, dynamic> toJson() => _$CampoToJson(this);
}
