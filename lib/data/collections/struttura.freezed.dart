// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'struttura.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Struttura _$StrutturaFromJson(Map<String, dynamic> json) {
  return _Struttura.fromJson(json);
}

/// @nodoc
mixin _$Struttura {
  String get id => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  String get indirizzo => throw _privateConstructorUsedError;
  String get citta => throw _privateConstructorUsedError;
  double get latitudine => throw _privateConstructorUsedError;
  double get longitudine => throw _privateConstructorUsedError;
  List<Sport> get sportPraticabili => throw _privateConstructorUsedError;

  /// Serializes this Struttura to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Struttura
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StrutturaCopyWith<Struttura> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StrutturaCopyWith<$Res> {
  factory $StrutturaCopyWith(Struttura value, $Res Function(Struttura) then) =
      _$StrutturaCopyWithImpl<$Res, Struttura>;
  @useResult
  $Res call({
    String id,
    String nome,
    String indirizzo,
    String citta,
    double latitudine,
    double longitudine,
    List<Sport> sportPraticabili,
  });
}

/// @nodoc
class _$StrutturaCopyWithImpl<$Res, $Val extends Struttura>
    implements $StrutturaCopyWith<$Res> {
  _$StrutturaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Struttura
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? indirizzo = null,
    Object? citta = null,
    Object? latitudine = null,
    Object? longitudine = null,
    Object? sportPraticabili = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nome: null == nome
                ? _value.nome
                : nome // ignore: cast_nullable_to_non_nullable
                      as String,
            indirizzo: null == indirizzo
                ? _value.indirizzo
                : indirizzo // ignore: cast_nullable_to_non_nullable
                      as String,
            citta: null == citta
                ? _value.citta
                : citta // ignore: cast_nullable_to_non_nullable
                      as String,
            latitudine: null == latitudine
                ? _value.latitudine
                : latitudine // ignore: cast_nullable_to_non_nullable
                      as double,
            longitudine: null == longitudine
                ? _value.longitudine
                : longitudine // ignore: cast_nullable_to_non_nullable
                      as double,
            sportPraticabili: null == sportPraticabili
                ? _value.sportPraticabili
                : sportPraticabili // ignore: cast_nullable_to_non_nullable
                      as List<Sport>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StrutturaImplCopyWith<$Res>
    implements $StrutturaCopyWith<$Res> {
  factory _$$StrutturaImplCopyWith(
    _$StrutturaImpl value,
    $Res Function(_$StrutturaImpl) then,
  ) = __$$StrutturaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String nome,
    String indirizzo,
    String citta,
    double latitudine,
    double longitudine,
    List<Sport> sportPraticabili,
  });
}

/// @nodoc
class __$$StrutturaImplCopyWithImpl<$Res>
    extends _$StrutturaCopyWithImpl<$Res, _$StrutturaImpl>
    implements _$$StrutturaImplCopyWith<$Res> {
  __$$StrutturaImplCopyWithImpl(
    _$StrutturaImpl _value,
    $Res Function(_$StrutturaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Struttura
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? indirizzo = null,
    Object? citta = null,
    Object? latitudine = null,
    Object? longitudine = null,
    Object? sportPraticabili = null,
  }) {
    return _then(
      _$StrutturaImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nome: null == nome
            ? _value.nome
            : nome // ignore: cast_nullable_to_non_nullable
                  as String,
        indirizzo: null == indirizzo
            ? _value.indirizzo
            : indirizzo // ignore: cast_nullable_to_non_nullable
                  as String,
        citta: null == citta
            ? _value.citta
            : citta // ignore: cast_nullable_to_non_nullable
                  as String,
        latitudine: null == latitudine
            ? _value.latitudine
            : latitudine // ignore: cast_nullable_to_non_nullable
                  as double,
        longitudine: null == longitudine
            ? _value.longitudine
            : longitudine // ignore: cast_nullable_to_non_nullable
                  as double,
        sportPraticabili: null == sportPraticabili
            ? _value._sportPraticabili
            : sportPraticabili // ignore: cast_nullable_to_non_nullable
                  as List<Sport>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StrutturaImpl implements _Struttura {
  const _$StrutturaImpl({
    this.id = '',
    required this.nome,
    required this.indirizzo,
    required this.citta,
    required this.latitudine,
    required this.longitudine,
    required final List<Sport> sportPraticabili,
  }) : _sportPraticabili = sportPraticabili;

  factory _$StrutturaImpl.fromJson(Map<String, dynamic> json) =>
      _$$StrutturaImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String nome;
  @override
  final String indirizzo;
  @override
  final String citta;
  @override
  final double latitudine;
  @override
  final double longitudine;
  final List<Sport> _sportPraticabili;
  @override
  List<Sport> get sportPraticabili {
    if (_sportPraticabili is EqualUnmodifiableListView)
      return _sportPraticabili;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sportPraticabili);
  }

  @override
  String toString() {
    return 'Struttura(id: $id, nome: $nome, indirizzo: $indirizzo, citta: $citta, latitudine: $latitudine, longitudine: $longitudine, sportPraticabili: $sportPraticabili)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StrutturaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.indirizzo, indirizzo) ||
                other.indirizzo == indirizzo) &&
            (identical(other.citta, citta) || other.citta == citta) &&
            (identical(other.latitudine, latitudine) ||
                other.latitudine == latitudine) &&
            (identical(other.longitudine, longitudine) ||
                other.longitudine == longitudine) &&
            const DeepCollectionEquality().equals(
              other._sportPraticabili,
              _sportPraticabili,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nome,
    indirizzo,
    citta,
    latitudine,
    longitudine,
    const DeepCollectionEquality().hash(_sportPraticabili),
  );

  /// Create a copy of Struttura
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StrutturaImplCopyWith<_$StrutturaImpl> get copyWith =>
      __$$StrutturaImplCopyWithImpl<_$StrutturaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StrutturaImplToJson(this);
  }
}

abstract class _Struttura implements Struttura {
  const factory _Struttura({
    final String id,
    required final String nome,
    required final String indirizzo,
    required final String citta,
    required final double latitudine,
    required final double longitudine,
    required final List<Sport> sportPraticabili,
  }) = _$StrutturaImpl;

  factory _Struttura.fromJson(Map<String, dynamic> json) =
      _$StrutturaImpl.fromJson;

  @override
  String get id;
  @override
  String get nome;
  @override
  String get indirizzo;
  @override
  String get citta;
  @override
  double get latitudine;
  @override
  double get longitudine;
  @override
  List<Sport> get sportPraticabili;

  /// Create a copy of Struttura
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StrutturaImplCopyWith<_$StrutturaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
