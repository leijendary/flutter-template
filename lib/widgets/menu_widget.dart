import 'package:flutter/material.dart';
import 'package:flutter_sample/models/Menu.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/product_widget.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class MenuGroup extends StatelessWidget {
  const MenuGroup(this._menu, {Key? key}) : super(key: key);

  final Menu _menu;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: GestureDetector(
        child: Container(
          color: context.theme.colorScheme.background,
          height: Sizes.appBarHeight,
          padding: const EdgeInsets.all(Spacings.standardPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            _menu.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            final product = _menu.products[i];

            return ProductListTile(product);
          },
          childCount: _menu.products.length,
        ),
      ),
    );
  }
}
