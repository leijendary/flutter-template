import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:flutter_sample/repositories/auth_repository.dart';
import 'package:flutter_sample/repositories/session_repository.dart';
import 'package:flutter_sample/states/session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionProvider = StateNotifierProvider<SessionProvider, SessionState>(
  (ref) {
    final authRepository = ref.read(authRepositoryProvider);
    final sessionRepository = ref.read(sessionRepositoryProvider);
    final user = sessionRepository.getUser() ?? GuestUser();
    final sessionState = SessionState(user: user);

    return SessionProvider(
      authRepository,
      sessionRepository,
      sessionState: sessionState,
    );
  },
);

class SessionProvider extends StateNotifier<SessionState> {
  SessionProvider(
    this._authRepository,
    this._sessionRepository, {
    required SessionState sessionState,
  }) : super(sessionState) {
    Amplify.Hub.listen([HubChannel.Auth], _authListener);
  }

  final AuthRepository _authRepository;
  final SessionRepository _sessionRepository;

  Future<void> initialize() async {
    final session = await _authRepository.session();
    final isSignedIn = session.isSignedIn;
    final user = isSignedIn ? await _authRepository.user() : GuestUser();

    await _sessionRepository.saveUser(user);

    state = SessionState(user: user);
  }

  Future<void> _authListener(HubEvent event) async {
    switch (event.eventName) {
      case "SIGNED_IN":
        await initialize();

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
