import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  final String codiceFiscale;
  final String cognome;
  final String email;
  final String name;
  final String password;
  final String ruolo;
  final List<String> preferiti;

  User({
    required this.id,
    required this.codiceFiscale,
    required this.cognome,
    required this.email,
    required this.name,
    required this.password,
    required this.ruolo,
    required this.preferiti,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
