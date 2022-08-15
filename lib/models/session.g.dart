// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionUser _$$_SessionUserFromJson(Map<String, dynamic> json) =>
    _$_SessionUser(
      id: json['id'] as String?,
      givenName: json['givenName'] as String?,
      familyName: json['familyName'] as String?,
      nickname: json['nickname'] as String?,
      countryCode: json['countryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      languageCode: json['languageCode'] as String? ?? "en",
      isGuest: json['isGuest'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SessionUserToJson(_$_SessionUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'nickname': instance.nickname,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'languageCode': instance.languageCode,
      'isGuest': instance.isGuest,
    };
