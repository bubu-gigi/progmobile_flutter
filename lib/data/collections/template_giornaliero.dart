import 'package:json_annotation/json_annotation.dart';

part 'template_giornaliero.g.dart';

@JsonSerializable()
class TemplateGiornaliero {
  final int giornoSettimana;
  final String orarioApertura;
  final String orarioChiusura;

  TemplateGiornaliero({
    required this.giornoSettimana,
    required this.orarioApertura,
    required this.orarioChiusura,
  });

  factory TemplateGiornaliero.fromJson(Map<String, dynamic> json) =>
      _$TemplateGiornalieroFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateGiornalieroToJson(this);
}
