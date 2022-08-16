import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

class Configs {
  Configs._();

  static const cacheExpires = 604800;
}

class ApiAuths {
  ApiAuths._();

  static const iam = "sample_iam";
  static const cognito = "sample_cognito";
}

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

  static const extraSmallPadding = 8.0;
  static const smallPadding = 12.0;
  static const regularPadding = 16.0;
  static const mediumPadding = 20.0;
  static const largePadding = 24.0;
  static const tileOuterPadding = regularPadding / 2;
  static const tileInnerPadding = 24.0;
  static const paragraphPadding = 2.0;
  static const iconSmallPadding = 4.0;
  static const iconMediumPadding = 8.0;
  static const fieldPadding = mediumPadding - 2;
  static const regularIsolation = 48.0;
}

class Sizes {
  Sizes._();

  static const appBarHeight = 56.0;
  static const listImageSize = 56.0;
  static const listTileHeight = 110.0;
  static const labelSmallIcon = 18.0;
  static const inputHeight = 40.0;
  static const promotionHeight = 180.0;
  static const tagButtonHeight = 30.0;
  static const searchRowHeight = 80.0;
  static const iconBox = 40.0;
  static const detailImageMinHeight = 220.0;
  static const detailImageMaxHeight = 360.0;
  static const cornerHeight = 30.0;
}

class Shapes {
  Shapes._();

  static const borderRadius = 8.0;
  static const imageRadius = 32.0;
  static const buttonRadius = 24.0;
  static const containerRadius = 28.0;
}

class Durations {
  Durations._();

  static const fadeDuration = Duration(milliseconds: 100);
}

class Boxes {
  Boxes._();

  static const all = [
    session,
    menu,
    product,
    cache,
  ];
  static const session = "session";
  static const menu = "menu";
  static const product = "product";
  static const cache = "cache";
}

class DatabaseKeys {
  DatabaseKeys._();

  static const user = "user";
  static const syncTimestamp = "sync_timestamp";
}

class Assets {
  Assets._();

  static const thumbnailDefault = "assets/images/thumbnail_default.png";
}

class Shadows {
  Shadows._();

  static const standardText = [
    Shadow(
      offset: Offset(0.5, 0.5),
      blurRadius: 10.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ];
}

class Prefixes {
  Prefixes._();

  static const storage = "storage:";
}
