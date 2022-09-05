import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/models/session.dart';
import 'package:template/utils/constants.dart';

final sessionDatabaseProvider = Provider((_) {
  final box = Hive.box(Boxes.session);

  return SessionDatabase(box);
});

class SessionDatabase {
  SessionDatabase(this._box);

  final Box _box;

  SessionUser? getUser() {
    final json = _box.get(DatabaseKeys.user);

    return json != null ? SessionUser.fromJson(json) : null;
  }

  Future<void> saveUser(SessionUser user) async {
    await _box.put(DatabaseKeys.user, user.toJson());
  }

  Future<void> removeUser() async => _box.delete(DatabaseKeys.user);
}
