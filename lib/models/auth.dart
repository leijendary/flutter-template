class SignInForm {
  String? countryCode;
  String? phoneNumber;
  String? pin;

  String get username => "$countryCode$phoneNumber";
}

class SignUpForm {
  String? givenName;
  String? familyName;
  String? countryCode;
  String? phoneNumber;
  String? pin;
  String? confirmPin;

  String get username => "$countryCode$phoneNumber";
}
