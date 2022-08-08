import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

class Keys {
  Keys._();

  static const phoneNumber = Key("phoneNumber");
  static const pin = Key("pin");
}

class AwsAttributes {
  AwsAttributes._();

  static const countryCode = CognitoUserAttributeKey.custom("country_code");
}

class Spacings {
  Spacings._();

  static const standardPadding = 16.0;
  static const appBarHeight = 56.0;
}

class Boxes {
  Boxes._();

  static const all = {session, menu, product};
  static const session = "session";
  static const menu = "menu";
  static const product = "product";
}

class DatabaseKeys {
  DatabaseKeys._();

  static const user = "user";
}
