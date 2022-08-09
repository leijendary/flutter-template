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
final menuUrlProvider = FutureProvider.family.autoDispose<String, String>(
  (ref, key) async => ref.read(menuProvider.notifier).getStorageUrl(key),
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
      final menus = response.items
          .whereType<Menu>()
          .where((menu) => menu.products.isNotEmpty)
          .toList();

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

  Future<String> getStorageUrl(String key) async {
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
