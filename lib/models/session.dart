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

  Map toJson() => {
        "id": id,
        "givenName": givenName,
        "familyName": familyName,
        "nickname": nickname,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "languageCode": languageCode,
        "isGuest": isGuest,
      };

  static SessionUser fromJson(Map json) => SessionUser(
        id: json["id"],
        givenName: json["givenName"],
        familyName: json["familyName"],
        nickname: json["nickname"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        languageCode: json["languageCode"],
        isGuest: json["isGuest"],
      );
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
