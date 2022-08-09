import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/Menu.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:flutter_sample/providers/menu_provider.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/top_bar_widget.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(menuProvider);

    return CustomScrollView(
      semanticChildCount: menuState.count,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _HomePageHeader(),
        ),
        for (var menu in menuState.menus) _MenuGroup(menu),
      ],
    );
  }
}

class _HomePageHeader extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return FractionallySizedBox(
      heightFactor: 1,
      widthFactor: 1,
      child: Container(
        color: context.theme.colorScheme.primary,
        child: Column(
          children: [
            const TopBar(title: "Aegyo"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacings.standardPadding,
                ),
                child: _HomePageHeaderContent(
                  shrinkOffset: shrinkOffset,
                  minExtent: minExtent,
                  maxExtent: maxExtent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageHeaderContent extends HookConsumerWidget {
  const _HomePageHeaderContent({
    required this.shrinkOffset,
    required this.minExtent,
    required this.maxExtent,
  });

  final double shrinkOffset;
  final double minExtent;
  final double maxExtent;

  static const _fontMultiplier = 12;
  static const _subHeader = "It's a good day for coffee.";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerStyle = useMemoized(() {
      return context.theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: _computeFontSize(
          context.theme.textTheme.titleLarge!.fontSize!,
        ),
      );
    }, [shrinkOffset]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(sessionProvider).user;
            String greeting;

            if (user.isGuest) {
              greeting = "Hello!";
            } else {
              greeting = "Hello ${user.givenName},";
            }

            return Text(
              greeting,
              style: headerStyle.copyWith(
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
        Text(
          _subHeader,
          style: headerStyle,
        ),
      ],
    );
  }

  double _computeFontSize(double original) {
    var limit = maxExtent - minExtent;
    var computed = min(limit, shrinkOffset) / minExtent;

    return original - (computed * _fontMultiplier);
  }
}

class _MenuGroup extends StatelessWidget {
  const _MenuGroup(this._menu, {Key? key}) : super(key: key);

  final Menu _menu;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: GestureDetector(
        child: Container(
          color: Colors.white,
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

            return _ProductListTile(product);
          },
          childCount: _menu.products.length,
        ),
      ),
    );
  }
}

class _ProductListTile extends HookWidget {
  const _ProductListTile(this._product);

  final Product _product;

  @override
  Widget build(BuildContext context) {
    final uri = _product.asset.thumbnail.uri ??
        _product.asset.full.uri ??
        _product.asset.master.uri;
    final thumbnail = useMemoized(() {
      final defaultImage = Image.asset(
        Assets.thumbnailDefault,
        semanticLabel: _product.name,
      );

      if (uri == null) {
        return defaultImage;
      }

      return CachedNetworkImage(
        cacheKey: _product.id,
        height: Sizes.listImageSize,
        width: Sizes.listImageSize,
        imageUrl: uri,
        placeholder: (context, url) => defaultImage,
        errorWidget: (context, url, error) => defaultImage,
        fadeInDuration: Durations.fadeDuration,
      );
    }, [uri]);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Spacings.tileOuterPadding,
        horizontal: Spacings.standardPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(Shapes.borderRadius),
        ),
        height: Sizes.listTileHeight,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(Spacings.standardPadding),
              child: Row(
                children: [
                  Flexible(
                    flex: 0,
                    child: thumbnail,
                  ),
                  const Flexible(
                    flex: 0,
                    child: SizedBox(
                      width: Spacings.tileInnerPadding,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: _ProductDetail(_product),
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class _ProductDetail extends HookWidget {
  const _ProductDetail(this._product);

  final Product _product;

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual price
    const originalPrice = 5.95;
    final price = useMemoized(() {
      final format = NumberFormat.simpleCurrency(
        locale: context.locale.toString(),
      );

      return format.format(originalPrice);
    }, [originalPrice]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _product.name,
                style: context.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: Spacings.textPadding,
                ),
                child: Text(
                  "Double espresso, steamed milk with white chocolate mocha, caramel macchiato, pomegranate pearls",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("⭐️ 5.0"),
            Text(
              price,
              style: context.theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
