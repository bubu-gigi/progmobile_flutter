// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get codiceFiscale => throw _privateConstructorUsedError;
  String get cognome => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get ruolo => throw _privateConstructorUsedError;
  List<String> get preferiti => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String codiceFiscale,
    String cognome,
    String email,
    String name,
    String password,
    String ruolo,
    List<String> preferiti,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? codiceFiscale = null,
    Object? cognome = null,
    Object? email = null,
    Object? name = null,
    Object? password = null,
    Object? ruolo = null,
    Object? preferiti = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            codiceFiscale: null == codiceFiscale
                ? _value.codiceFiscale
                : codiceFiscale // ignore: cast_nullable_to_non_nullable
                      as String,
            cognome: null == cognome
                ? _value.cognome
                : cognome // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            ruolo: null == ruolo
                ? _value.ruolo
                : ruolo // ignore: cast_nullable_to_non_nullable
                      as String,
            preferiti: null == preferiti
                ? _value.preferiti
                : preferiti // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String codiceFiscale,
    String cognome,
    String email,
    String name,
    String password,
    String ruolo,
    List<String> preferiti,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? codiceFiscale = null,
    Object? cognome = null,
    Object? email = null,
    Object? name = null,
    Object? password = null,
    Object? ruolo = null,
    Object? preferiti = null,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        codiceFiscale: null == codiceFiscale
            ? _value.codiceFiscale
            : codiceFiscale // ignore: cast_nullable_to_non_nullable
                  as String,
        cognome: null == cognome
            ? _value.cognome
            : cognome // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        ruolo: null == ruolo
            ? _value.ruolo
            : ruolo // ignore: cast_nullable_to_non_nullable
                  as String,
        preferiti: null == preferiti
            ? _value._preferiti
            : preferiti // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    required this.id,
    required this.codiceFiscale,
    required this.cognome,
    required this.email,
    required this.name,
    required this.password,
    required this.ruolo,
    required final List<String> preferiti,
  }) : _preferiti = preferiti;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String codiceFiscale;
  @override
  final String cognome;
  @override
  final String email;
  @override
  final String name;
  @override
  final String password;
  @override
  final String ruolo;
  final List<String> _preferiti;
  @override
  List<String> get preferiti {
    if (_preferiti is EqualUnmodifiableListView) return _preferiti;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferiti);
  }

  @override
  String toString() {
    return 'User(id: $id, codiceFiscale: $codiceFiscale, cognome: $cognome, email: $email, name: $name, password: $password, ruolo: $ruolo, preferiti: $preferiti)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.codiceFiscale, codiceFiscale) ||
                other.codiceFiscale == codiceFiscale) &&
            (identical(other.cognome, cognome) || other.cognome == cognome) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.ruolo, ruolo) || other.ruolo == ruolo) &&
            const DeepCollectionEquality().equals(
              other._preferiti,
              _preferiti,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    codiceFiscale,
    cognome,
    email,
    name,
    password,
    ruolo,
    const DeepCollectionEquality().hash(_preferiti),
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    required final String id,
    required final String codiceFiscale,
    required final String cognome,
    required final String email,
    required final String name,
    required final String password,
    required final String ruolo,
    required final List<String> preferiti,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get codiceFiscale;
  @override
  String get cognome;
  @override
  String get email;
  @override
  String get name;
  @override
  String get password;
  @override
  String get ruolo;
  @override
  List<String> get preferiti;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
