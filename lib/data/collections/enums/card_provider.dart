import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum CardProvider {
  VISA,
  MASTERCARD,
  AMEX,
}
