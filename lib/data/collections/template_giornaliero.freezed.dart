// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_giornaliero.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TemplateGiornaliero _$TemplateGiornalieroFromJson(Map<String, dynamic> json) {
  return _TemplateGiornaliero.fromJson(json);
}

/// @nodoc
mixin _$TemplateGiornaliero {
  int get giornoSettimana => throw _privateConstructorUsedError;
  String get orarioApertura => throw _privateConstructorUsedError;
  String get orarioChiusura => throw _privateConstructorUsedError;

  /// Serializes this TemplateGiornaliero to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TemplateGiornaliero
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TemplateGiornalieroCopyWith<TemplateGiornaliero> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateGiornalieroCopyWith<$Res> {
  factory $TemplateGiornalieroCopyWith(
    TemplateGiornaliero value,
    $Res Function(TemplateGiornaliero) then,
  ) = _$TemplateGiornalieroCopyWithImpl<$Res, TemplateGiornaliero>;
  @useResult
  $Res call({
    int giornoSettimana,
    String orarioApertura,
    String orarioChiusura,
  });
}

/// @nodoc
class _$TemplateGiornalieroCopyWithImpl<$Res, $Val extends TemplateGiornaliero>
    implements $TemplateGiornalieroCopyWith<$Res> {
  _$TemplateGiornalieroCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TemplateGiornaliero
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? giornoSettimana = null,
    Object? orarioApertura = null,
    Object? orarioChiusura = null,
  }) {
    return _then(
      _value.copyWith(
            giornoSettimana: null == giornoSettimana
                ? _value.giornoSettimana
                : giornoSettimana // ignore: cast_nullable_to_non_nullable
                      as int,
            orarioApertura: null == orarioApertura
                ? _value.orarioApertura
                : orarioApertura // ignore: cast_nullable_to_non_nullable
                      as String,
            orarioChiusura: null == orarioChiusura
                ? _value.orarioChiusura
                : orarioChiusura // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TemplateGiornalieroImplCopyWith<$Res>
    implements $TemplateGiornalieroCopyWith<$Res> {
  factory _$$TemplateGiornalieroImplCopyWith(
    _$TemplateGiornalieroImpl value,
    $Res Function(_$TemplateGiornalieroImpl) then,
  ) = __$$TemplateGiornalieroImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int giornoSettimana,
    String orarioApertura,
    String orarioChiusura,
  });
}

/// @nodoc
class __$$TemplateGiornalieroImplCopyWithImpl<$Res>
    extends _$TemplateGiornalieroCopyWithImpl<$Res, _$TemplateGiornalieroImpl>
    implements _$$TemplateGiornalieroImplCopyWith<$Res> {
  __$$TemplateGiornalieroImplCopyWithImpl(
    _$TemplateGiornalieroImpl _value,
    $Res Function(_$TemplateGiornalieroImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TemplateGiornaliero
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? giornoSettimana = null,
    Object? orarioApertura = null,
    Object? orarioChiusura = null,
  }) {
    return _then(
      _$TemplateGiornalieroImpl(
        giornoSettimana: null == giornoSettimana
            ? _value.giornoSettimana
            : giornoSettimana // ignore: cast_nullable_to_non_nullable
                  as int,
        orarioApertura: null == orarioApertura
            ? _value.orarioApertura
            : orarioApertura // ignore: cast_nullable_to_non_nullable
                  as String,
        orarioChiusura: null == orarioChiusura
            ? _value.orarioChiusura
            : orarioChiusura // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TemplateGiornalieroImpl implements _TemplateGiornaliero {
  const _$TemplateGiornalieroImpl({
    required this.giornoSettimana,
    required this.orarioApertura,
    required this.orarioChiusura,
  });

  factory _$TemplateGiornalieroImpl.fromJson(Map<String, dynamic> json) =>
      _$$TemplateGiornalieroImplFromJson(json);

  @override
  final int giornoSettimana;
  @override
  final String orarioApertura;
  @override
  final String orarioChiusura;

  @override
  String toString() {
    return 'TemplateGiornaliero(giornoSettimana: $giornoSettimana, orarioApertura: $orarioApertura, orarioChiusura: $orarioChiusura)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateGiornalieroImpl &&
            (identical(other.giornoSettimana, giornoSettimana) ||
                other.giornoSettimana == giornoSettimana) &&
            (identical(other.orarioApertura, orarioApertura) ||
                other.orarioApertura == orarioApertura) &&
            (identical(other.orarioChiusura, orarioChiusura) ||
                other.orarioChiusura == orarioChiusura));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, giornoSettimana, orarioApertura, orarioChiusura);

  /// Create a copy of TemplateGiornaliero
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateGiornalieroImplCopyWith<_$TemplateGiornalieroImpl> get copyWith =>
      __$$TemplateGiornalieroImplCopyWithImpl<_$TemplateGiornalieroImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TemplateGiornalieroImplToJson(this);
  }
}

abstract class _TemplateGiornaliero implements TemplateGiornaliero {
  const factory _TemplateGiornaliero({
    required final int giornoSettimana,
    required final String orarioApertura,
    required final String orarioChiusura,
  }) = _$TemplateGiornalieroImpl;

  factory _TemplateGiornaliero.fromJson(Map<String, dynamic> json) =
      _$TemplateGiornalieroImpl.fromJson;

  @override
  int get giornoSettimana;
  @override
  String get orarioApertura;
  @override
  String get orarioChiusura;

  /// Create a copy of TemplateGiornaliero
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TemplateGiornalieroImplCopyWith<_$TemplateGiornalieroImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
