import 'package:flutter_sample/databases/session_database.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionRepositoryProvider = Provider((ref) {
  final sessionDatabase = ref.read(sessionDatabaseProvider);

  return SessionRepository(sessionDatabase);
});

class SessionRepository {
  SessionRepository(this._sessionDatabase);

  final SessionDatabase _sessionDatabase;

  SessionUser getUser() => _sessionDatabase.getUser() ?? SessionUser.guest();

  Future<void> saveUser(SessionUser user) async =>
      _sessionDatabase.saveUser(user);

  Future<void> removeUser() async => _sessionDatabase.removeUser();
}
