import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sample/models/auth.dart';
import 'package:flutter_sample/repositories/auth_repository.dart';
import 'package:flutter_sample/states/auth_state.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthProvider, AuthState>(
  (_) => AuthProvider(),
);

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState());

  final _authRepository = AuthRepository();

  void signIn(BuildContext context, SignInForm signInForm) async {
    state = AuthState(isLoading: true);

    final localizations = context.localizations;
    final SignInResult result;

    try {
      result = await _authRepository.signIn(signInForm);

      if (result.nextStep?.signInStep == "CONFIRM_SIGN_UP") {
        state = AuthState(shouldConfirm: true);

        return;
      }

      state = AuthState(isSignedIn: true);

      return;
    } on UserNotFoundException catch (_) {
      state = AuthState(
        error: {
          Keys.phoneNumber: localizations.noAccount,
        },
      );
    } on NotAuthorizedException catch (_) {
      state = AuthState(
        error: {
          Keys.phoneNumber: localizations.invalidCredentials,
          Keys.pin: localizations.invalidCredentials,
        },
      );
    } on UserNotConfirmedException catch (_) {
      state = AuthState(shouldConfirm: true);
    } on InvalidStateException catch (_) {
      state = AuthState(isSignedIn: true);
    }
  }

  void signOut() async {
    state = AuthState(isLoading: true);

    await _authRepository.signOut();

    state = AuthState();
  }
}
