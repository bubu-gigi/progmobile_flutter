// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Campo _$CampoFromJson(Map<String, dynamic> json) {
  return _Campo.fromJson(json);
}

/// @nodoc
mixin _$Campo {
  String get id => throw _privateConstructorUsedError;
  String get nomeCampo => throw _privateConstructorUsedError;
  Sport get sport => throw _privateConstructorUsedError;
  TipologiaTerreno get tipologiaTerreno => throw _privateConstructorUsedError;
  double get prezzoOrario => throw _privateConstructorUsedError;
  int get numeroGiocatori => throw _privateConstructorUsedError;
  bool get spogliatoi => throw _privateConstructorUsedError;
  List<TemplateGiornaliero> get disponibilitaSettimanale =>
      throw _privateConstructorUsedError;

  /// Serializes this Campo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Campo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampoCopyWith<Campo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampoCopyWith<$Res> {
  factory $CampoCopyWith(Campo value, $Res Function(Campo) then) =
      _$CampoCopyWithImpl<$Res, Campo>;
  @useResult
  $Res call({
    String id,
    String nomeCampo,
    Sport sport,
    TipologiaTerreno tipologiaTerreno,
    double prezzoOrario,
    int numeroGiocatori,
    bool spogliatoi,
    List<TemplateGiornaliero> disponibilitaSettimanale,
  });
}

/// @nodoc
class _$CampoCopyWithImpl<$Res, $Val extends Campo>
    implements $CampoCopyWith<$Res> {
  _$CampoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Campo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nomeCampo = null,
    Object? sport = null,
    Object? tipologiaTerreno = null,
    Object? prezzoOrario = null,
    Object? numeroGiocatori = null,
    Object? spogliatoi = null,
    Object? disponibilitaSettimanale = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nomeCampo: null == nomeCampo
                ? _value.nomeCampo
                : nomeCampo // ignore: cast_nullable_to_non_nullable
                      as String,
            sport: null == sport
                ? _value.sport
                : sport // ignore: cast_nullable_to_non_nullable
                      as Sport,
            tipologiaTerreno: null == tipologiaTerreno
                ? _value.tipologiaTerreno
                : tipologiaTerreno // ignore: cast_nullable_to_non_nullable
                      as TipologiaTerreno,
            prezzoOrario: null == prezzoOrario
                ? _value.prezzoOrario
                : prezzoOrario // ignore: cast_nullable_to_non_nullable
                      as double,
            numeroGiocatori: null == numeroGiocatori
                ? _value.numeroGiocatori
                : numeroGiocatori // ignore: cast_nullable_to_non_nullable
                      as int,
            spogliatoi: null == spogliatoi
                ? _value.spogliatoi
                : spogliatoi // ignore: cast_nullable_to_non_nullable
                      as bool,
            disponibilitaSettimanale: null == disponibilitaSettimanale
                ? _value.disponibilitaSettimanale
                : disponibilitaSettimanale // ignore: cast_nullable_to_non_nullable
                      as List<TemplateGiornaliero>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CampoImplCopyWith<$Res> implements $CampoCopyWith<$Res> {
  factory _$$CampoImplCopyWith(
    _$CampoImpl value,
    $Res Function(_$CampoImpl) then,
  ) = __$$CampoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String nomeCampo,
    Sport sport,
    TipologiaTerreno tipologiaTerreno,
    double prezzoOrario,
    int numeroGiocatori,
    bool spogliatoi,
    List<TemplateGiornaliero> disponibilitaSettimanale,
  });
}

/// @nodoc
class __$$CampoImplCopyWithImpl<$Res>
    extends _$CampoCopyWithImpl<$Res, _$CampoImpl>
    implements _$$CampoImplCopyWith<$Res> {
  __$$CampoImplCopyWithImpl(
    _$CampoImpl _value,
    $Res Function(_$CampoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Campo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nomeCampo = null,
    Object? sport = null,
    Object? tipologiaTerreno = null,
    Object? prezzoOrario = null,
    Object? numeroGiocatori = null,
    Object? spogliatoi = null,
    Object? disponibilitaSettimanale = null,
  }) {
    return _then(
      _$CampoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nomeCampo: null == nomeCampo
            ? _value.nomeCampo
            : nomeCampo // ignore: cast_nullable_to_non_nullable
                  as String,
        sport: null == sport
            ? _value.sport
            : sport // ignore: cast_nullable_to_non_nullable
                  as Sport,
        tipologiaTerreno: null == tipologiaTerreno
            ? _value.tipologiaTerreno
            : tipologiaTerreno // ignore: cast_nullable_to_non_nullable
                  as TipologiaTerreno,
        prezzoOrario: null == prezzoOrario
            ? _value.prezzoOrario
            : prezzoOrario // ignore: cast_nullable_to_non_nullable
                  as double,
        numeroGiocatori: null == numeroGiocatori
            ? _value.numeroGiocatori
            : numeroGiocatori // ignore: cast_nullable_to_non_nullable
                  as int,
        spogliatoi: null == spogliatoi
            ? _value.spogliatoi
            : spogliatoi // ignore: cast_nullable_to_non_nullable
                  as bool,
        disponibilitaSettimanale: null == disponibilitaSettimanale
            ? _value._disponibilitaSettimanale
            : disponibilitaSettimanale // ignore: cast_nullable_to_non_nullable
                  as List<TemplateGiornaliero>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CampoImpl implements _Campo {
  const _$CampoImpl({
    this.id = '',
    required this.nomeCampo,
    required this.sport,
    this.tipologiaTerreno = TipologiaTerreno.ERBA_SINTETICA,
    this.prezzoOrario = 0.0,
    this.numeroGiocatori = 0,
    this.spogliatoi = false,
    final List<TemplateGiornaliero> disponibilitaSettimanale = const [],
  }) : _disponibilitaSettimanale = disponibilitaSettimanale;

  factory _$CampoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CampoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String nomeCampo;
  @override
  final Sport sport;
  @override
  @JsonKey()
  final TipologiaTerreno tipologiaTerreno;
  @override
  @JsonKey()
  final double prezzoOrario;
  @override
  @JsonKey()
  final int numeroGiocatori;
  @override
  @JsonKey()
  final bool spogliatoi;
  final List<TemplateGiornaliero> _disponibilitaSettimanale;
  @override
  @JsonKey()
  List<TemplateGiornaliero> get disponibilitaSettimanale {
    if (_disponibilitaSettimanale is EqualUnmodifiableListView)
      return _disponibilitaSettimanale;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_disponibilitaSettimanale);
  }

  @override
  String toString() {
    return 'Campo(id: $id, nomeCampo: $nomeCampo, sport: $sport, tipologiaTerreno: $tipologiaTerreno, prezzoOrario: $prezzoOrario, numeroGiocatori: $numeroGiocatori, spogliatoi: $spogliatoi, disponibilitaSettimanale: $disponibilitaSettimanale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nomeCampo, nomeCampo) ||
                other.nomeCampo == nomeCampo) &&
            (identical(other.sport, sport) || other.sport == sport) &&
            (identical(other.tipologiaTerreno, tipologiaTerreno) ||
                other.tipologiaTerreno == tipologiaTerreno) &&
            (identical(other.prezzoOrario, prezzoOrario) ||
                other.prezzoOrario == prezzoOrario) &&
            (identical(other.numeroGiocatori, numeroGiocatori) ||
                other.numeroGiocatori == numeroGiocatori) &&
            (identical(other.spogliatoi, spogliatoi) ||
                other.spogliatoi == spogliatoi) &&
            const DeepCollectionEquality().equals(
              other._disponibilitaSettimanale,
              _disponibilitaSettimanale,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nomeCampo,
    sport,
    tipologiaTerreno,
    prezzoOrario,
    numeroGiocatori,
    spogliatoi,
    const DeepCollectionEquality().hash(_disponibilitaSettimanale),
  );

  /// Create a copy of Campo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampoImplCopyWith<_$CampoImpl> get copyWith =>
      __$$CampoImplCopyWithImpl<_$CampoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CampoImplToJson(this);
  }
}

abstract class _Campo implements Campo {
  const factory _Campo({
    final String id,
    required final String nomeCampo,
    required final Sport sport,
    final TipologiaTerreno tipologiaTerreno,
    final double prezzoOrario,
    final int numeroGiocatori,
    final bool spogliatoi,
    final List<TemplateGiornaliero> disponibilitaSettimanale,
  }) = _$CampoImpl;

  factory _Campo.fromJson(Map<String, dynamic> json) = _$CampoImpl.fromJson;

  @override
  String get id;
  @override
  String get nomeCampo;
  @override
  Sport get sport;
  @override
  TipologiaTerreno get tipologiaTerreno;
  @override
  double get prezzoOrario;
  @override
  int get numeroGiocatori;
  @override
  bool get spogliatoi;
  @override
  List<TemplateGiornaliero> get disponibilitaSettimanale;

  /// Create a copy of Campo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampoImplCopyWith<_$CampoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
