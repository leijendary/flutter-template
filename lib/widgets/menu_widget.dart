import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:template/models/Menu.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/product_widget.dart';

class MenuGroup extends StatelessWidget {
  const MenuGroup({
    super.key,
    required this.menu,
  });

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SliverStickyHeader(
      header: Container(
        alignment: Alignment.centerLeft,
        color: colorScheme.background,
        padding: const EdgeInsets.all(Spacings.regularPadding),
        child: Text(
          menu.name,
          style: textTheme.labelLarge,
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
