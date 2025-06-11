// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Carta _$CartaFromJson(Map<String, dynamic> json) {
  return _Carta.fromJson(json);
}

/// @nodoc
mixin _$Carta {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get cardHolderName => throw _privateConstructorUsedError;
  String get cardNumber => throw _privateConstructorUsedError;
  int get expirationMonth => throw _privateConstructorUsedError;
  int get expirationYear => throw _privateConstructorUsedError;
  String get cvv => throw _privateConstructorUsedError;
  CardProvider get provider => throw _privateConstructorUsedError;

  /// Serializes this Carta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Carta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartaCopyWith<Carta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartaCopyWith<$Res> {
  factory $CartaCopyWith(Carta value, $Res Function(Carta) then) =
      _$CartaCopyWithImpl<$Res, Carta>;
  @useResult
  $Res call({
    String id,
    String userId,
    String cardHolderName,
    String cardNumber,
    int expirationMonth,
    int expirationYear,
    String cvv,
    CardProvider provider,
  });
}

/// @nodoc
class _$CartaCopyWithImpl<$Res, $Val extends Carta>
    implements $CartaCopyWith<$Res> {
  _$CartaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Carta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cardHolderName = null,
    Object? cardNumber = null,
    Object? expirationMonth = null,
    Object? expirationYear = null,
    Object? cvv = null,
    Object? provider = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            cardHolderName: null == cardHolderName
                ? _value.cardHolderName
                : cardHolderName // ignore: cast_nullable_to_non_nullable
                      as String,
            cardNumber: null == cardNumber
                ? _value.cardNumber
                : cardNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            expirationMonth: null == expirationMonth
                ? _value.expirationMonth
                : expirationMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            expirationYear: null == expirationYear
                ? _value.expirationYear
                : expirationYear // ignore: cast_nullable_to_non_nullable
                      as int,
            cvv: null == cvv
                ? _value.cvv
                : cvv // ignore: cast_nullable_to_non_nullable
                      as String,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as CardProvider,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartaImplCopyWith<$Res> implements $CartaCopyWith<$Res> {
  factory _$$CartaImplCopyWith(
    _$CartaImpl value,
    $Res Function(_$CartaImpl) then,
  ) = __$$CartaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String cardHolderName,
    String cardNumber,
    int expirationMonth,
    int expirationYear,
    String cvv,
    CardProvider provider,
  });
}

/// @nodoc
class __$$CartaImplCopyWithImpl<$Res>
    extends _$CartaCopyWithImpl<$Res, _$CartaImpl>
    implements _$$CartaImplCopyWith<$Res> {
  __$$CartaImplCopyWithImpl(
    _$CartaImpl _value,
    $Res Function(_$CartaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Carta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cardHolderName = null,
    Object? cardNumber = null,
    Object? expirationMonth = null,
    Object? expirationYear = null,
    Object? cvv = null,
    Object? provider = null,
  }) {
    return _then(
      _$CartaImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        cardHolderName: null == cardHolderName
            ? _value.cardHolderName
            : cardHolderName // ignore: cast_nullable_to_non_nullable
                  as String,
        cardNumber: null == cardNumber
            ? _value.cardNumber
            : cardNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        expirationMonth: null == expirationMonth
            ? _value.expirationMonth
            : expirationMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        expirationYear: null == expirationYear
            ? _value.expirationYear
            : expirationYear // ignore: cast_nullable_to_non_nullable
                  as int,
        cvv: null == cvv
            ? _value.cvv
            : cvv // ignore: cast_nullable_to_non_nullable
                  as String,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as CardProvider,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CartaImpl implements _Carta {
  const _$CartaImpl({
    required this.id,
    required this.userId,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expirationMonth,
    required this.expirationYear,
    required this.cvv,
    required this.provider,
  });

  factory _$CartaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartaImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String cardHolderName;
  @override
  final String cardNumber;
  @override
  final int expirationMonth;
  @override
  final int expirationYear;
  @override
  final String cvv;
  @override
  final CardProvider provider;

  @override
  String toString() {
    return 'Carta(id: $id, userId: $userId, cardHolderName: $cardHolderName, cardNumber: $cardNumber, expirationMonth: $expirationMonth, expirationYear: $expirationYear, cvv: $cvv, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cardHolderName, cardHolderName) ||
                other.cardHolderName == cardHolderName) &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.expirationMonth, expirationMonth) ||
                other.expirationMonth == expirationMonth) &&
            (identical(other.expirationYear, expirationYear) ||
                other.expirationYear == expirationYear) &&
            (identical(other.cvv, cvv) || other.cvv == cvv) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    cardHolderName,
    cardNumber,
    expirationMonth,
    expirationYear,
    cvv,
    provider,
  );

  /// Create a copy of Carta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartaImplCopyWith<_$CartaImpl> get copyWith =>
      __$$CartaImplCopyWithImpl<_$CartaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartaImplToJson(this);
  }
}

abstract class _Carta implements Carta {
  const factory _Carta({
    required final String id,
    required final String userId,
    required final String cardHolderName,
    required final String cardNumber,
    required final int expirationMonth,
    required final int expirationYear,
    required final String cvv,
    required final CardProvider provider,
  }) = _$CartaImpl;

  factory _Carta.fromJson(Map<String, dynamic> json) = _$CartaImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get cardHolderName;
  @override
  String get cardNumber;
  @override
  int get expirationMonth;
  @override
  int get expirationYear;
  @override
  String get cvv;
  @override
  CardProvider get provider;

  /// Create a copy of Carta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartaImplCopyWith<_$CartaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
