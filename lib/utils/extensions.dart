import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/Menu.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:flutter_sample/models/ProductAsset.dart';
import 'package:flutter_sample/models/ProductAssetUri.dart';
import 'package:flutter_sample/models/ProductAvailability.dart';

extension MenuHelper on Menu {
  static Menu fromJson(dynamic json) {
    var menu = Menu(
      id: json["id"],
      name: json["name"],
      ordinal: json["ordinal"],
      children: const [],
      products: const [],
      typeName: Menu.schema.name,
    );
    final products = json["products"] != null
        ? (json["products"] as List).map(
            (e) {
              e["menu"] = menu;

              return ProductHelper.fromJson(e);
            },
          ).toList()
        : List<Product>.empty();

    menu = menu.copyWith(products: products);

    return menu;
  }
}

extension ProductHelper on Product {
  static Product fromJson(dynamic json) {
    return Product(
      id: json["id"],
      name: json["name"],
      code: 0,
      ordinal: json["ordinal"],
      menu: json["menu"] is Menu
          ? json["menu"]
          : Menu.fromJson(Map.from(json["menu"])),
      availability: enumFromString<ProductAvailability>(
        json['availability'],
        ProductAvailability.values,
      )!,
      asset: ProductAssetHelper.fromJson(json["asset"]),
      sizes: json["sizes"],
      typeName: Product.schema.name,
    );
  }
}

extension ProductAssetHelper on ProductAsset {
  static ProductAsset fromJson(dynamic json) {
    return ProductAsset(
      thumbnail: ProductAssetUriHelper.fromJson(json["thumbnail"]),
      full: ProductAssetUriHelper.fromJson(json["full"]),
      master: ProductAssetUriHelper.fromJson(json["master"]),
    );
  }
}

extension ProductAssetUriHelper on ProductAssetUri {
  static ProductAssetUri fromJson(dynamic json) {
    return ProductAssetUri(uri: json != null ? json["uri"] : null);
  }
}
