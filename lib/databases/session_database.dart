import 'package:flutter_sample/models/session.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hive/hive.dart';

class SessionDatabase {
  final _box = Hive.box(Boxes.session);

  SessionUser getUser() {
    final json = _box.get(DatabaseKeys.user);

    return SessionUser.fromJson(json);
  }

  Future<void> saveUser(SessionUser user) async {
    await _box.put(DatabaseKeys.user, user.toJson());
  }

  Future<void> removeUser() async {
    await _box.delete(DatabaseKeys.user);
  }
}
