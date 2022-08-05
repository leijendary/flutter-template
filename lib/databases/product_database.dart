import 'package:flutter_sample/models/ModelProvider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hive/hive.dart';

class ProductDatabase {
  final _box = Hive.box(Boxes.product);

  Future<void> add({
    required Product product,
    required int index,
    required String menuId,
  }) async {
    final json = product.toJson();
    final key = _getKey(menuId, index);

    return await _box.put(key, json);
  }

  Product get(String menuId, int index) {
    final key = _getKey(menuId, index);
    final json = _box.get(key);

    return Product.fromJson(json);
  }

  int size() => _box.length;

  Future<void> clear() => _box.clear();

  String _getKey(String menuId, int index) => "$menuId.$index";
}
