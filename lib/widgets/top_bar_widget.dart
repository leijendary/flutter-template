import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/cart_page.dart';
import 'package:flutter_sample/pages/main_page.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:go_router/go_router.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.fancy = false,
    this.center = false,
  });

  final String title;
  final bool fancy;
  final bool center;

  @override
  Size get preferredSize => const Size.fromHeight(Sizes.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final leading = !context.router.canPop()
        ? null
        : IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () => context.router.pop(),
          );

    return AppBar(
      centerTitle: center,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: fancy
                ? context.theme.textTheme.titleLarge
                : context.theme.textTheme.titleMedium,
          ),
          Visibility(
            visible: context.router.location == MainPage.path,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                    width: Spacings.iconSmallPadding,
                  ),
                ),
                Text(
                  "Hilltop Batangas City, Philippines",
                  style: context.theme.textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
      leading: leading,
      actions: [
        Visibility(
          visible: context.router.location != CartPage.path,
          child: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.pushNamed(CartPage.name),
          ),
        ),
      ],
    );
  }
}
