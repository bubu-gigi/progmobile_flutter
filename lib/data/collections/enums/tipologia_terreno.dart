enum TipologiaTerreno {
  ERBA_SINTETICA,
  CEMENTO,
}

extension TipologiaTerrenoExtension on TipologiaTerreno {
  static TipologiaTerreno? fromString(String? value) {
    if (value == null) return null;
    return TipologiaTerreno.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => TipologiaTerreno.ERBA_SINTETICA,
    );
  }

  String get label {
    switch (this) {
      case TipologiaTerreno.ERBA_SINTETICA:
        return 'Erba sintetica';
      case TipologiaTerreno.CEMENTO:
        return 'Cemento';
    }
  }
}
