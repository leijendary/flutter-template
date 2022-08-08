import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_sample/models/ModelProvider.dart';
import 'package:flutter_sample/repositories/menu_repository.dart';
import 'package:flutter_sample/states/menu_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuProvider = StateNotifierProvider.autoDispose<MenuProvider, MenuState>(
  (ref) {
    final menuRepository = ref.read(menuRepositoryProvider);

    return MenuProvider(menuRepository);
  },
);

class MenuProvider extends StateNotifier<MenuState> {
  MenuProvider(this._menuRepository) : super(MenuState()) {
    list();
  }

  final MenuRepository _menuRepository;

  Future<void> list() async {
    state = MenuState(
      count: state.count,
      isLoading: true,
      error: null,
    );

    try {
      final response = await _menuRepository.list();
      final filtered = response.items
          .whereType<Menu>()
          .where((menu) => menu.products.isNotEmpty);
      final mapper = filtered.map((menu) async => await _setAssetUris(menu));
      final menus = await Future.wait(mapper);

      state = MenuState(
        menus: menus,
        count: menus.length,
        isLoading: false,
        error: null,
      );
    } catch (exception, stacktrace) {
      FirebaseCrashlytics.instance.recordError(exception, stacktrace);

      state = MenuState(
        count: 0,
        isLoading: false,
        error: "Could not load menu",
      );
    }
  }

  Future<Menu> _setAssetUris(Menu menu) async {
    final mapper = menu.products.map((product) async {
      var asset = product.asset;
      final full = await _setAssetUri(asset.full);
      final thumbnail = await _setAssetUri(asset.thumbnail);
      final master = await _setAssetUri(asset.master);

      asset = asset.copyWith(
        full: full,
        thumbnail: thumbnail,
        master: master,
      );

      return product.copyWith(
        code: 0,
        ordinal: 0,
        category: ProductCategory.Beverage,
        asset: asset,
        menu: menu,
        typeName: Product.schema.name,
      );
    });
    final products = await Future.wait(mapper);

    return menu.copyWith(
      children: const [],
      products: products,
      typeName: Menu.schema.name,
    );
  }

  Future<ProductAssetUri> _setAssetUri(ProductAssetUri asset) async {
    var uri = asset.uri;

    if (uri == null) {
      return asset;
    }

    uri = await _getStorageUrl(uri);

    return asset.copyWith(uri: uri);
  }

  Future<String> _getStorageUrl(String key) async {
    final result = await Amplify.Storage.getUrl(
      key: key,
      options: GetUrlOptions(
        // Set expiration to 7 days
        expires: 604800,
      ),
    );

    return result.url;
  }
}
