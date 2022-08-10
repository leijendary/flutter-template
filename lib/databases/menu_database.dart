import 'package:flutter_sample/models/Menu.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuDatabaseProvider = Provider((_) {
  final box = Hive.box(Boxes.menu);

  return MenuDatabase(box);
});

class MenuDatabase {
  MenuDatabase(this._box);

  final Box _box;
  final List<String> excludedKeys = [
    DatabaseKeys.sync_timestamp,
  ];

  List<Menu> all() {
    final map = _box.toMap();
    map.removeWhere((key, value) => excludedKeys.contains(key));

    return map.entries
        .map(
          (entry) => Menu.fromJson(entry.value),
        )
        .toList();
  }

  Future<void> put(Menu menu) async => await _box.put(menu.id, menu.toJson());

  int getSyncTimestamp() => _box.get(
        DatabaseKeys.sync_timestamp,
        defaultValue: 0,
      );

  Future<void> setSyncTimestamp(int timestamp) async =>
      await _box.put(DatabaseKeys.sync_timestamp, timestamp);
}
