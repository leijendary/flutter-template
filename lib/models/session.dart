class SessionUser {
  SessionUser({
    this.id,
    this.givenName,
    this.familyName,
    this.nickname,
    this.countryCode,
    this.phoneNumber,
    this.languageCode = "en",
    this.isGuest = false,
  });

  String? id;
  String? givenName;
  String? familyName;
  String? nickname;
  String? countryCode;
  String? phoneNumber;
  String languageCode;
  bool isGuest;

  String get fullName => "$givenName $familyName";
}

class GuestUser extends SessionUser {
  GuestUser()
      : super(
          givenName: "Guest",
          familyName: "User",
          nickname: "Guest",
          languageCode: "nl",
          isGuest: true,
        );
}
