import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
      final menus = await _menuRepository.synced();

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
}
