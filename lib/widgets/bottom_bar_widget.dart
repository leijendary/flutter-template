import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
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
      selectedItemColor: Theme.of(context).colorScheme.secondary,
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
