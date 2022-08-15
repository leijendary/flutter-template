import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class SessionUser with _$SessionUser {
  const SessionUser._();

  const factory SessionUser({
    String? id,
    String? givenName,
    String? familyName,
    String? nickname,
    String? countryCode,
    String? phoneNumber,
    @Default("en") String languageCode,
    @Default(false) bool isGuest,
  }) = _SessionUser;

  String get fullName => "$givenName $familyName";

  static SessionUser guest() => const SessionUser(
        givenName: "Guest",
        familyName: "User",
        nickname: "Guest",
        languageCode: "nl",
        isGuest: true,
      );

  factory SessionUser.fromJson(Map<String, dynamic> json) =>
      _$SessionUserFromJson(json);
}
