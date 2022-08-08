import 'package:flutter_sample/models/Menu.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuDatabase = Provider((_) {
  final box = Hive.box(Boxes.menu);

  return MenuDatabase(box);
});

class MenuDatabase {
  MenuDatabase(this._box);

  final Box _box;

  Future<void> add({
    required Menu menu,
    required int index,
    String? parentId,
  }) async {
    final json = menu.toJson();
    json.remove("children");
    json.remove("products");

    if (parentId != null) {
      final key = _getKey(parentId, index);

      return await _box.put(key, json);
    }

    await _box.add(json);
  }

  Future<void> clear() async => _box.clear();

  bool isEmpty() => _box.isEmpty;

  int size() => _box.length;

  String _getKey(String parentId, int index) => "$parentId.$index";
}
