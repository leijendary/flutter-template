import 'package:flutter/widgets.dart';
import 'package:flutter_sample/models/Menu.dart';

class MenuState {
  MenuState({
    required this.menus,
    this.size = 50,
    this.total = 0,
    this.isLoading = false,
    this.hasNext = false,
    this.error = const {},
  });

  List<Menu> menus;
  int size;
  int total;
  bool isLoading;
  bool hasNext;
  Map<Key, String> error;
}
