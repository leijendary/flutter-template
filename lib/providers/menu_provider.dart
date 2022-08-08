import 'package:flutter_sample/repositories/menu_repository.dart';
import 'package:flutter_sample/states/menu_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuProvider = StateNotifierProvider.autoDispose<MenuProvider, MenuState>(
  (ref) {
    final repository = ref.read(menuRepository);

    return MenuProvider(repository);
  },
);

final menuListProvider = FutureProvider.autoDispose.family<MenuState, String>(
  (ref, nextToken) => ref.read(menuProvider.notifier).list(nextToken),
);

class MenuProvider extends StateNotifier<MenuState> {
  MenuProvider(this._menuRepository) : super(MenuState(menus: const []));

  final MenuRepository _menuRepository;

  Future<MenuState> list(String? nextToken) async {
    return Future.value(MenuState(menus: const []));
  }
}
