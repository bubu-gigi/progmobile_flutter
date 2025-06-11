import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String codiceFiscale,
    required String cognome,
    required String email,
    required String name,
    required String password,
    required String ruolo,
    required List<String> preferiti,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
