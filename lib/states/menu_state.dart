import 'package:template/models/Menu.dart';

class MenuState {
  MenuState({
    this.menus = const [],
    this.tags = const [
      "Your favorites",
      "Popular",
      "Recommended",
      "New",
      "Season Specials",
    ],
    this.count = 0,
    this.isLoading = false,
    this.tag = "",
    this.error,
  });

  List<Menu> menus;
  List<String> tags;
  int count;
  bool isLoading;
  String tag;
  String? error;

  MenuState copyWith({
    List<Menu>? menus,
    List<String>? tags,
    int? count,
    bool? isLoading,
    String? tag,
    String? error,
  }) =>
      MenuState(
        menus: menus ?? this.menus,
        tags: tags ?? this.tags,
        count: count ?? this.count,
        isLoading: isLoading ?? this.isLoading,
        tag: tag ?? this.tag,
        error: error ?? this.error,
      );
}
