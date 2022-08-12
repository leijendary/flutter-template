import 'package:flutter/material.dart';
import 'package:flutter_sample/models/Menu.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/product_widget.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

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

            return ProductListTile(product: product);
          },
          childCount: menu.products.length,
        ),
      ),
    );
  }
}
