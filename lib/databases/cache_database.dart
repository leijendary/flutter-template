import 'package:flutter_sample/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cacheDatabaseProvider = Provider((_) {
  final box = Hive.box(Boxes.cache);

  return CacheDatabase(box);
});

class CacheDatabase {
  CacheDatabase(this._box);

  final Box _box;

  Future<dynamic> get(String key) async {
    final json = _box.get(key);
    final expires = json?["expires"];

    if (expires != null) {
      final expiresOn = DateTime.fromMillisecondsSinceEpoch(int.parse(expires));

      if (DateTime.now().compareTo(expiresOn) > 0) {
        return await _box.delete(key);
      }
    }

    return json;
  }

  Future<void> put({
    required String key,
    required dynamic json,
    int? expires,
  }) async {
    if (expires != null) {
      final now = DateTime.now().add(Duration(seconds: expires));

      json["expires"] = now.millisecondsSinceEpoch.toString();
    }

    await _box.put(key, json);
  }
}
