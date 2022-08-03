import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepository = Provider.autoDispose((_) => AuthRepository());

class AuthRepository {
  Future<SignInResult> signIn(String username, String password) async =>
      await Amplify.Auth.signIn(
        username: username,
        password: password,
      );

  Future<void> signOut() async => await Amplify.Auth.signOut();

  Future<AuthSession> session() async => await Amplify.Auth.fetchAuthSession();

  Future<SessionUser> user() async {
    final currentUser = await Amplify.Auth.getCurrentUser();
    final userAttributes = await Amplify.Auth.fetchUserAttributes();
    final attributeMap = {
      for (var element in userAttributes)
        element.userAttributeKey.key: element.value
    };
    final givenName = attributeMap[CognitoUserAttributeKey.givenName.key];
    final familyName = attributeMap[CognitoUserAttributeKey.familyName.key];
    final countryCode = attributeMap[AwsAttributes.countryCode.key];
    final phoneNumber = attributeMap[CognitoUserAttributeKey.phoneNumber.key]!
        .replaceFirst(countryCode!, "");

    return SessionUser(
      id: currentUser.userId,
      givenName: givenName,
      familyName: familyName,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );
  }
}
