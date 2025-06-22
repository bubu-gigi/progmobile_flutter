import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TipologiaTerreno {
  ERBA_SINTETICA,
  CEMENTO,
}

extension TipologiaTerrenoExtension on TipologiaTerreno {
  String get label {
    switch (this) {
      case TipologiaTerreno.ERBA_SINTETICA:
        return 'Erba Sintetica';
      case TipologiaTerreno.CEMENTO:
        return 'Cemento';
    }
  }
}