import 'dart:async';

import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/apis/menu_api.dart';
import 'package:flutter_sample/databases/menu_database.dart';
import 'package:flutter_sample/databases/product_database.dart';
import 'package:flutter_sample/models/Menu.dart';

class MenuRepository {
  final _menuDatabase = MenuDatabase();
  final _productDatabase = ProductDatabase();
  final _api = MenuApi();

  Future<String?> refill(String? currentETag) async {
    final apiETag = await _api.eTag();

    if (currentETag != null && apiETag == currentETag) {
      return apiETag;
    }

    _menuDatabase.clear();
    _productDatabase.clear();

    final menus = await _api.all();

    for (var i = 0; i < menus.length; i++) {
      var menu = menus[i];

      await _addMenus(
        menu: menu,
        index: i,
      );
    }

    return apiETag;
  }

  Future<GraphQLResponse<PaginatedResult<Menu>>> list({
    required int limit,
    String? nextToken,
  }) async {
    const listMenus = "listMenus";
    const query = """
      query (\$limit: Int!, \$nextToken: String) {
        $listMenus(limit: \$limit, nextToken: \$nextToken) {
          items {
            id
            name
            description
            image
            price
          }
          nextToken
        }
      }
    """;
    final request = GraphQLRequest<PaginatedResult<Menu>>(
      document: query,
      modelType: const PaginatedModelType(Menu.classType),
      variables: <String, dynamic>{
        "limit": limit,
        "nextToken": nextToken,
      },
      decodePath: listMenus,
      apiName: "sample",
    );

    return await Amplify.API.query(request: request).response;
  }

  Future<GraphQLResponse<Menu>> create(Menu menu) async {
    final mutation = ModelMutations.create(menu);
    final request = GraphQLRequest<Menu>(
      document: mutation.document,
      decodePath: mutation.decodePath,
      modelType: mutation.modelType,
      variables: mutation.variables,
      apiName: "sample_cognito",
    );

    return await Amplify.API.mutate(request: request).response;
  }

  Future<void> _addMenus({
    required Menu menu,
    required int index,
    String? parentId,
  }) async {
    await create(menu);

    if (parentId == null) {
      await _menuDatabase.add(
        menu: menu,
        index: index,
      );
    }

    for (var i = 0; i < menu.children.length; i++) {
      final child = menu.children[i];

      await _menuDatabase.add(
        menu: child,
        index: i,
        parentId: parentId,
      );

      await _addMenus(
        menu: child,
        parentId: menu.id,
        index: i,
      );
      await _addProducts(
        menu: child,
        index: i,
      );
    }
  }

  Future<void> _addProducts({
    required Menu menu,
    required int index,
  }) async {
    for (var i = 0; i < menu.products.length; i++) {
      final product = menu.products[i];

      await _productDatabase.add(
        product: product,
        index: i,
        menuId: menu.id,
      );
    }
  }
}
