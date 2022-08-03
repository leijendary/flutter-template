import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:flutter_sample/repositories/auth_repository.dart';
import 'package:flutter_sample/states/session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late final StateNotifierProvider<SessionNotifier, SessionState> sessionProvider;

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier(
    this.ref, {
    required SessionState sessionState,
  }) : super(sessionState) {
    Amplify.Hub.listen([HubChannel.Auth], _authListener);
  }

  final Ref ref;

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

  sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((ref) {
    return SessionNotifier(
      ref,
      sessionState: SessionState(user: user),
    );
  });
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
