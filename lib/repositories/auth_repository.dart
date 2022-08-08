import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/auth.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepository = Provider((_) => AuthRepository());

class AuthRepository {
  Future<SignUpResult> signUp(SignUpForm signUpForm) async {
    final userAttributes = <CognitoUserAttributeKey, String>{
      CognitoUserAttributeKey.givenName: signUpForm.givenName!,
      CognitoUserAttributeKey.familyName: signUpForm.familyName!,
      AwsAttributes.countryCode: signUpForm.countryCode!,
      CognitoUserAttributeKey.phoneNumber: signUpForm.username,
    };
    final options = CognitoSignUpOptions(userAttributes: userAttributes);

    return await Amplify.Auth.signUp(
      username: signUpForm.username,
      password: signUpForm.pin!,
      options: options,
    );
  }

  Future<SignUpResult> confirmSignUp(
    String username,
    String confirmationCode,
  ) async =>
      await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );

  Future<SignInResult> signIn(SignInForm signInForm) async =>
      await Amplify.Auth.signIn(
        username: signInForm.username,
        password: signInForm.pin,
      );

  Future<void> signOut() async => await Amplify.Auth.signOut();

  Future<AuthSession> session() async => await Amplify.Auth.fetchAuthSession();

  Future<SessionUser> user() async {
    final currentUser = await Amplify.Auth.getCurrentUser();
    final userAttributes = await Amplify.Auth.fetchUserAttributes();
    final attributeMap = {
      for (var attribute in userAttributes)
        attribute.userAttributeKey.key: attribute.value
    };
    final givenName = attributeMap[CognitoUserAttributeKey.givenName.key];
    final familyName = attributeMap[CognitoUserAttributeKey.familyName.key];
    final nickname = attributeMap[CognitoUserAttributeKey.nickname.key];
    final countryCode = attributeMap[AwsAttributes.countryCode.key];
    final phoneNumber = attributeMap[CognitoUserAttributeKey.phoneNumber.key]!
        .replaceFirst(countryCode!, "");

    return SessionUser(
      id: currentUser.userId,
      givenName: givenName,
      familyName: familyName,
      nickname: nickname,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );
  }
}
