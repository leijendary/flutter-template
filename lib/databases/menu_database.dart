import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/models/Menu.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/extensions.dart';

final menuDatabaseProvider = Provider((_) {
  final box = Hive.box(Boxes.menu);

  return MenuDatabase(box);
});

class MenuDatabase {
  MenuDatabase(this._box);

  final Box _box;
  final List<String> excludedKeys = [
    DatabaseKeys.syncTimestamp,
  ];

  List<Menu> all() {
    final map = _box.toMap();
    map.removeWhere((key, value) => excludedKeys.contains(key));

    return map.entries
        .map((entry) => MenuHelper.fromJson(entry.value))
        .toList();
  }

  Menu get(String id) {
    final json = _box.get(id);

    return MenuHelper.fromJson(json);
  }

  Future<void> put(Menu menu) async {
    final json = menu.toJson();

    await _box.put(menu.id, json);
  }

  int getSyncTimestamp() => _box.get(
        DatabaseKeys.syncTimestamp,
        defaultValue: 0,
      );

  Future<void> setSyncTimestamp(int timestamp) async =>
      await _box.put(DatabaseKeys.syncTimestamp, timestamp);
}
