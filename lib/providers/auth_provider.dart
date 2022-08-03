import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sample/models/auth.dart';
import 'package:flutter_sample/repositories/auth_repository.dart';
import 'package:flutter_sample/states/auth_state.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthProvider, AsyncValue<AuthState>>(
  (ref) => AuthProvider(ref),
);

class AuthProvider extends StateNotifier<AsyncValue<AuthState>> {
  AuthProvider(this.ref) : super(AsyncData(AuthState()));

  final Ref ref;

  void signIn(BuildContext context, SignInForm signInForm) async {
    state = const AsyncLoading();

    final localizations = context.localizations;
    final SignInResult result;

    try {
      result = await ref.read(authRepository).signIn(signInForm);

      if (result.nextStep?.signInStep == "CONFIRM_SIGN_UP") {
        state = AsyncData(AuthState(shouldConfirm: true));

        return;
      }

      state = AsyncData(AuthState(isSignedIn: true));

      return;
    } on UserNotFoundException catch (_) {
      state = AsyncError(AuthState(error: {
        Keys.phoneNumber: localizations.noAccount,
      }));
    } on NotAuthorizedException catch (_) {
      state = AsyncError(AuthState(error: {
        Keys.phoneNumber: localizations.invalidCredentials,
        Keys.pin: localizations.invalidCredentials,
      }));
    } on UserNotConfirmedException catch (_) {
      state = AsyncError(AuthState(shouldConfirm: true));
    } on InvalidStateException catch (_) {
      state = AsyncData(AuthState(isSignedIn: true));
    }
  }

  void signOut() async {
    state = const AsyncLoading();

    await ref.read(authRepository).signOut();

    state = AsyncData(AuthState());
  }
}
