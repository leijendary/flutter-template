import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/models/Product.dart';
import 'package:template/repositories/menu_repository.dart';
import 'package:template/repositories/product_repository.dart';
import 'package:template/states/menu_state.dart';

final menuProvider = StateNotifierProvider.autoDispose<MenuProvider, MenuState>(
  (ref) {
    final menuRepository = ref.read(menuRepositoryProvider);
    final productRepository = ref.read(productRepositoryProvider);

    return MenuProvider(menuRepository, productRepository);
  },
);

class MenuProvider extends StateNotifier<MenuState> {
  MenuProvider(this._menuRepository, this._productRepository)
      : super(MenuState()) {
    list();
  }

  final MenuRepository _menuRepository;
  final ProductRepository _productRepository;

  Future<void> list({String? tag}) async {
    state = state.copyWith(
      count: state.count,
      tag: tag,
      isLoading: true,
      error: null,
    );

    try {
      final menus = await _menuRepository.synced();

      for (var menu in menus) {
        await Future.forEach<Product>(menu.products, (product) async {
          _productRepository.put(product);
        });
      }

      state = state.copyWith(
        menus: menus,
        count: menus.length,
        tag: tag,
        isLoading: false,
        error: null,
      );
    } catch (exception, stacktrace) {
      FirebaseCrashlytics.instance.recordError(exception, stacktrace);

      state = state.copyWith(
        count: 0,
        isLoading: false,
        error: "Could not load menu",
      );
    }
  }
}
