import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_giornaliero.freezed.dart';
part 'template_giornaliero.g.dart';

@freezed
class TemplateGiornaliero with _$TemplateGiornaliero {
  const factory TemplateGiornaliero({
    required int giornoSettimana,
    required String orarioApertura,
    required String orarioChiusura,
  }) = _TemplateGiornaliero;

  factory TemplateGiornaliero.fromJson(Map<String, dynamic> json) =>
      _$TemplateGiornalieroFromJson(json);
}
