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

  static const padding = 16.0;
  static const paddingStandard = 16.0;
  static const appBarHeight = 56.0;
}

class Boxes {
  Boxes._();

  static const all = {menu, product};
  static const menu = "menu";
  static const product = "product";
}
