import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:flutter_sample/repositories/auth_repository.dart';
import 'package:flutter_sample/repositories/session_repository.dart';
import 'package:flutter_sample/states/session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionProvider = StateNotifierProvider<SessionProvider, SessionState>(
  (ref) {
    final repository = ref.read(sessionRepository);
    final user = repository.getUser();
    final sessionState = SessionState(user: user);

    return SessionProvider(
      repository,
      sessionState: sessionState,
    );
  },
);

class SessionProvider extends StateNotifier<SessionState> {
  SessionProvider(
    this._sessionRepository, {
    required SessionState sessionState,
  }) : super(sessionState) {
    Amplify.Hub.listen([HubChannel.Auth], _authListener);
  }

  final SessionRepository _sessionRepository;

  Future<void> _authListener(HubEvent event) async {
    switch (event.eventName) {
      case "SIGNED_IN":
        final user = await _getUser();

        await _sessionRepository.saveUser(user);

        state = SessionState(user: user);

        break;
      case "SIGNED_OUT":
      case "SESSION_EXPIRED":
      case "USER_DELETED":
        await _sessionRepository.removeUser();

        state = SessionState(user: GuestUser());

        break;
    }
  }
}

Future<void> session() async {
  final user = await _getUser();
  final sessionRepository = SessionRepository();

  await sessionRepository.saveUser(user);
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
