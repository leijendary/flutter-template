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
      title: Column(
        children: [
          Text(
            title,
            style: context.theme.textTheme.titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 0,
                child: Icon(
                  Icons.location_on_outlined,
                  color: context.theme.colorScheme.tertiary,
                  size: Sizes.labelSmallIcon,
                ),
              ),
              const Flexible(
                flex: 0,
                child: SizedBox(
                  width: Spacings.textPadding,
                ),
              ),
              Text(
                "Hilltop Batangas City, Philippines",
                style: context.theme.textTheme.labelSmall,
              )
            ],
          ),
          const SizedBox(
            height: Spacings.textPadding,
          ),
        ],
      ),
      actions: [
        if (context.router.location != CartPage.path)
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.pushNamed(CartPage.name),
          ),
      ],
    );
  }
}
