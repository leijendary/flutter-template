import 'package:flutter_sample/models/Menu.dart';

class MenuState {
  MenuState({
    this.menus = const [],
    this.count = 0,
    this.isLoading = false,
    this.error,
  });

  List<Menu> menus;
  int count;
  bool isLoading;
  String? error;
}
