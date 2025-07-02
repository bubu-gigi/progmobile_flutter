import 'package:freezed_annotation/freezed_annotation.dart';

part 'prenotazione.freezed.dart';
part 'prenotazione.g.dart';

@freezed
class Prenotazione with _$Prenotazione {
  const factory Prenotazione({
    @Default('') String id,
    required String userId,
    required String strutturaId,
    required String campoId,
    required String data,
    required String orarioInizio,
    required String orarioFine,
    required String campoNome,
    required String strutturaNome,
    @Default(false) bool pubblica,
  }) = _Prenotazione;

  factory Prenotazione.fromJson(Map<String, dynamic> json) =>
      _$PrenotazioneFromJson(json);
}
