import 'package:flutter_sample/databases/session_database.dart';
import 'package:flutter_sample/models/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionRepository = Provider((_) => SessionRepository());

class SessionRepository {
  final _sessionDatabase = SessionDatabase();

  SessionUser getUser() => _sessionDatabase.getUser();

  Future<void> saveUser(SessionUser user) async =>
      _sessionDatabase.saveUser(user);

  Future<void> removeUser() async => _sessionDatabase.removeUser();
}
