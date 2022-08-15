// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionUser _$SessionUserFromJson(Map<String, dynamic> json) {
  return _SessionUser.fromJson(json);
}

/// @nodoc
mixin _$SessionUser {
  String? get id => throw _privateConstructorUsedError;
  String? get givenName => throw _privateConstructorUsedError;
  String? get familyName => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String get languageCode => throw _privateConstructorUsedError;
  bool get isGuest => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionUserCopyWith<SessionUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionUserCopyWith<$Res> {
  factory $SessionUserCopyWith(
          SessionUser value, $Res Function(SessionUser) then) =
      _$SessionUserCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? givenName,
      String? familyName,
      String? nickname,
      String? countryCode,
      String? phoneNumber,
      String languageCode,
      bool isGuest});
}

/// @nodoc
class _$SessionUserCopyWithImpl<$Res> implements $SessionUserCopyWith<$Res> {
  _$SessionUserCopyWithImpl(this._value, this._then);

  final SessionUser _value;
  // ignore: unused_field
  final $Res Function(SessionUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? givenName = freezed,
    Object? familyName = freezed,
    Object? nickname = freezed,
    Object? countryCode = freezed,
    Object? phoneNumber = freezed,
    Object? languageCode = freezed,
    Object? isGuest = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      givenName: givenName == freezed
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: familyName == freezed
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      languageCode: languageCode == freezed
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      isGuest: isGuest == freezed
          ? _value.isGuest
          : isGuest // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_SessionUserCopyWith<$Res>
    implements $SessionUserCopyWith<$Res> {
  factory _$$_SessionUserCopyWith(
          _$_SessionUser value, $Res Function(_$_SessionUser) then) =
      __$$_SessionUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? givenName,
      String? familyName,
      String? nickname,
      String? countryCode,
      String? phoneNumber,
      String languageCode,
      bool isGuest});
}

/// @nodoc
class __$$_SessionUserCopyWithImpl<$Res> extends _$SessionUserCopyWithImpl<$Res>
    implements _$$_SessionUserCopyWith<$Res> {
  __$$_SessionUserCopyWithImpl(
      _$_SessionUser _value, $Res Function(_$_SessionUser) _then)
      : super(_value, (v) => _then(v as _$_SessionUser));

  @override
  _$_SessionUser get _value => super._value as _$_SessionUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? givenName = freezed,
    Object? familyName = freezed,
    Object? nickname = freezed,
    Object? countryCode = freezed,
    Object? phoneNumber = freezed,
    Object? languageCode = freezed,
    Object? isGuest = freezed,
  }) {
    return _then(_$_SessionUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      givenName: givenName == freezed
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: familyName == freezed
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      languageCode: languageCode == freezed
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      isGuest: isGuest == freezed
          ? _value.isGuest
          : isGuest // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SessionUser extends _SessionUser {
  const _$_SessionUser(
      {this.id,
      this.givenName,
      this.familyName,
      this.nickname,
      this.countryCode,
      this.phoneNumber,
      this.languageCode = "en",
      this.isGuest = false})
      : super._();

  factory _$_SessionUser.fromJson(Map<String, dynamic> json) =>
      _$$_SessionUserFromJson(json);

  @override
  final String? id;
  @override
  final String? givenName;
  @override
  final String? familyName;
  @override
  final String? nickname;
  @override
  final String? countryCode;
  @override
  final String? phoneNumber;
  @override
  @JsonKey()
  final String languageCode;
  @override
  @JsonKey()
  final bool isGuest;

  @override
  String toString() {
    return 'SessionUser(id: $id, givenName: $givenName, familyName: $familyName, nickname: $nickname, countryCode: $countryCode, phoneNumber: $phoneNumber, languageCode: $languageCode, isGuest: $isGuest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionUser &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.givenName, givenName) &&
            const DeepCollectionEquality()
                .equals(other.familyName, familyName) &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality()
                .equals(other.countryCode, countryCode) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality()
                .equals(other.languageCode, languageCode) &&
            const DeepCollectionEquality().equals(other.isGuest, isGuest));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(givenName),
      const DeepCollectionEquality().hash(familyName),
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(countryCode),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(languageCode),
      const DeepCollectionEquality().hash(isGuest));

  @JsonKey(ignore: true)
  @override
  _$$_SessionUserCopyWith<_$_SessionUser> get copyWith =>
      __$$_SessionUserCopyWithImpl<_$_SessionUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionUserToJson(
      this,
    );
  }
}

abstract class _SessionUser extends SessionUser {
  const factory _SessionUser(
      {final String? id,
      final String? givenName,
      final String? familyName,
      final String? nickname,
      final String? countryCode,
      final String? phoneNumber,
      final String languageCode,
      final bool isGuest}) = _$_SessionUser;
  const _SessionUser._() : super._();

  factory _SessionUser.fromJson(Map<String, dynamic> json) =
      _$_SessionUser.fromJson;

  @override
  String? get id;
  @override
  String? get givenName;
  @override
  String? get familyName;
  @override
  String? get nickname;
  @override
  String? get countryCode;
  @override
  String? get phoneNumber;
  @override
  String get languageCode;
  @override
  bool get isGuest;
  @override
  @JsonKey(ignore: true)
  _$$_SessionUserCopyWith<_$_SessionUser> get copyWith =>
      throw _privateConstructorUsedError;
}
