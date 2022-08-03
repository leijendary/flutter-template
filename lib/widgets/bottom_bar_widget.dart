import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/extensions.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.index,
    required this.onIndexChange,
  });

  final int index;
  final ValueChanged<int> onIndexChange;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: context.theme.colorScheme.onPrimary,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.person),
        ),
      ],
      onTap: onIndexChange,
    );
  }
}
