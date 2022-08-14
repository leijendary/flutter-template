import 'package:flutter_sample/databases/product_database.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productRepositoryProvider = Provider((ref) {
  final productDatabase = ref.read(productDatabaseProvider);

  return ProductRepository(productDatabase);
});

class ProductRepository {
  ProductRepository(this._productDatabase);

  final ProductDatabase _productDatabase;

  Product get(String id) => _productDatabase.get(id);

  Future<void> put(Product product) async =>
      await _productDatabase.put(product);
}
