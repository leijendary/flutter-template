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
  static const tileOuterPadding = standardPadding / 2;
  static const tileInnerPadding = 24.0;
  static const textPadding = 4.0;
}

class Sizes {
  Sizes._();

  static const appBarHeight = 56.0;
  static const listImageSize = 56.0;
  static const listTileHeight = 110.0;
  static const labelSmallIcon = 18.0;
}

class Shapes {
  Shapes._();

  static const borderRadius = 8.0;
}

class Durations {
  Durations._();

  static const fadeDuration = Duration(milliseconds: 200);
}

class Boxes {
  Boxes._();

  static const all = {session, menu};
  static const session = "session";
  static const menu = "menu";
}

class DatabaseKeys {
  DatabaseKeys._();

  static const user = "user";
  static const sync_timestamp = "sync_timestamp";
}

class Assets {
  Assets._();

  static const thumbnailDefault = "assets/images/thumbnail_default.png";
}
