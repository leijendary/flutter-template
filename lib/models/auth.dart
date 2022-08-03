class SignInForm {
  String? countryCode;
  String? phoneNumber;
  String? pin;

  String get username => "$countryCode$phoneNumber";
}
