import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:flutter_sample/repositories/auth_repository.dart';
import 'package:flutter_sample/states/session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late final StateNotifierProvider<SessionProvider, SessionState> sessionProvider;

class SessionProvider extends StateNotifier<SessionState> {
  SessionProvider({
    required SessionState sessionState,
  }) : super(sessionState) {
    Amplify.Hub.listen([HubChannel.Auth], _authListener);
  }

  Future<void> _authListener(HubEvent event) async {
    switch (event.eventName) {
      case "SIGNED_IN":
      case "SIGNED_OUT":
      case "SESSION_EXPIRED":
      case "USER_DELETED":
        final user = await _getUser();

        state = SessionState(user: user);

        break;
    }
  }
}

Future<void> session() async {
  final user = await _getUser();

  sessionProvider = StateNotifierProvider<SessionProvider, SessionState>(
    (_) => SessionProvider(
      sessionState: SessionState(user: user),
    ),
  );
}

Future<SessionUser> _getUser() async {
  final authRepository = AuthRepository();
  final session = await authRepository.session();
  final isSignedIn = session.isSignedIn;

  if (!isSignedIn) {
    return GuestUser();
  }

  return await authRepository.user();
}
