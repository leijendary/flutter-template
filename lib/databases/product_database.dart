import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/models/Product.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/extensions.dart';

final productDatabaseProvider = Provider((_) {
  final box = Hive.box(Boxes.product);

  return ProductDatabase(box);
});

class ProductDatabase {
  ProductDatabase(this._box);

  final Box _box;

  Product get(String id) {
    final json = _box.get(id);

    return ProductHelper.fromJson(json);
  }

  Future<void> put(Product product) async {
    final json = product.toJson();

    await _box.put(product.id, json);
  }
}
