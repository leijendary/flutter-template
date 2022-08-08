import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/cart_page.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:go_router/go_router.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(Sizes.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (context.router.location != CartPage.path)
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.pushNamed(CartPage.name),
          ),
      ],
    );
  }
}
