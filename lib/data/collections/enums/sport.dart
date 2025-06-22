import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum Sport {
  CALCIO5,
  CALCIO8,
  TENNIS,
  PADEL,
  BEACH_VOLLEY,
}

extension SportExtension on Sport {
  String get label {
    switch (this) {
      case Sport.CALCIO5:
        return 'Calcio a 5';
      case Sport.CALCIO8:
        return 'Calcio a 8';
      case Sport.TENNIS:
        return 'Tennis';
      case Sport.PADEL:
        return 'Padel';
      case Sport.BEACH_VOLLEY:
        return 'Beach Volley';
    }
  }
}

