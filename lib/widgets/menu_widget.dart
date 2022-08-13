import 'package:flutter/material.dart';
import 'package:flutter_sample/models/Menu.dart';
import 'package:flutter_sample/providers/menu_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/product_widget.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MenuGroupSliver extends ConsumerWidget {
  const MenuGroupSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(menuProvider);

    return MultiSliver(
      children: [
        for (var menu in menuState.menus)
          MenuGroup(
            key: Key(menu.id),
            menu: menu,
          ),
      ],
    );
  }
}

class MenuGroup extends StatelessWidget {
  const MenuGroup({super.key, required this.menu});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        alignment: Alignment.centerLeft,
        color: context.theme.colorScheme.background,
        padding: const EdgeInsets.all(Spacings.regularPadding),
        child: Text(
          menu.name,
          style: context.theme.textTheme.labelLarge,
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            final product = menu.products[i];

            return ProductListTile(
              key: Key(product.id),
              product: product,
            );
          },
          childCount: menu.products.length,
        ),
      ),
    );
  }
}
