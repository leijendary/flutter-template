import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:template/models/ModelProvider.dart';

final menuApiProvider = Provider((_) => MenuApi());

class MenuApi {
  final _url = Uri.parse(dotenv.env["MENU_API_URL"]!);

  Future<String?> eTag() async {
    final response = await http.head(_url);
    final headers = response.headers;

    return headers["etag"];
  }

  Future<List<Menu>> all() async {
    final response = await http.get(_url);
    final menus = <Menu>[];

    json
        .decode(response.body)["menus"]
        .map((json) => _toMenu(null, json))
        .forEach((menu) => menus.add(menu));

    return menus;
  }

  Menu _toMenu(Menu? parent, Map<String, dynamic> json) {
    var menu = Menu(
      name: json["name"],
      ordinal: json["displayOrder"],
      parent: parent,
      products: const [],
      children: const [],
      typeName: Menu.schema.name,
    );

    final children = <Menu>[];
    final products = <Product>[];

    json["children"]
        .map((child) => _toMenu(menu, child))
        .forEach((child) => children.add(child));

    json["products"]
        .map((product) => _toProduct(menu, product))
        .forEach((product) => products.add(product));

    return menu.copyWith(
      children: children,
      products: products,
    );
  }

  Product _toProduct(Menu menu, Map<String, dynamic> json) {
    ProductCategory category;

    switch (json["productType"]) {
      case "Beverage":
        category = ProductCategory.Beverage;
        break;
      case "Food":
        category = ProductCategory.Food;
        break;
      case "Coffee":
        category = ProductCategory.Coffee;
        break;
      default:
        throw Exception(
          "Invalid value ${json['productType']} for ProductCategory",
        );
    }

    ProductAvailability availability;

    switch (json["availability"]) {
      case "Available":
        availability = ProductAvailability.Available;
        break;
      case "NotAvailableHere":
        availability = ProductAvailability.NotAvailable;
        break;
      default:
        throw Exception(
          "Invalid value ${json['availability']} for Availability",
        );
    }

    final sizes = <String>[];

    json["sizes"]
        .map((size) => size["sizeCode"])
        .forEach((size) => sizes.add(size));

    return Product(
      name: json["name"],
      code: json["productNumber"],
      ordinal: json["displayOrder"],
      category: category,
      availability: availability,
      asset: _toAsset(json["assets"]),
      sizes: sizes,
      menu: menu,
      typeName: Product.schema.name,
    );
  }

  ProductAsset _toAsset(Map<String, dynamic> json) {
    final thumbnail = json["thumbnail"]["large"]["uri"];
    final full = json["fullSize"]["uri"];
    final master = json["masterImage"]["uri"];

    return ProductAsset(
      thumbnail: ProductAssetUri(
        uri: thumbnail,
      ),
      full: ProductAssetUri(
        uri: full,
      ),
      master: ProductAssetUri(
        uri: master,
      ),
    );
  }
}
