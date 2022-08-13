import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/image_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ProductListTile extends HookConsumerWidget {
  const ProductListTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Spacings.tileOuterPadding,
        horizontal: Spacings.regularPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(Shapes.borderRadius),
        ),
        height: Sizes.listTileHeight,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(Shapes.borderRadius),
            child: Padding(
              padding: const EdgeInsets.all(Spacings.regularPadding),
              child: Row(
                children: [
                  Flexible(
                    flex: 0,
                    child: _ProductThumbnail(product: product),
                  ),
                  const Flexible(
                    flex: 0,
                    child: SizedBox(
                      width: Spacings.tileInnerPadding,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: _ProductDetail(product: product),
                  )
                ],
              ),
            ),
            onTap: () => print("${product.name} tapped!"),
          ),
        ),
      ),
    );
  }
}

class _ProductThumbnail extends HookConsumerWidget {
  const _ProductThumbnail({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uri = product.asset.thumbnail.uri ??
        product.asset.full.uri ??
        product.asset.master.uri;

    return StorageImage(
      cacheKey: product.id,
      uri: uri,
      height: Sizes.listImageSize,
      width: Sizes.listImageSize,
    );
  }
}

class _ProductDetail extends HookWidget {
  const _ProductDetail({required this.product});

  final Product product;

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
                product.name,
                style: context.theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: Spacings.paragraphPadding,
              ),
              Text(
                "Double espresso, steamed milk",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: context.theme.colorScheme.secondary,
                  size: Sizes.labelSmallIcon,
                ),
                const SizedBox(
                  width: Spacings.iconMediumPadding,
                ),
                Text(
                  "5.0",
                  style: context.theme.textTheme.bodySmall,
                ),
              ],
            ),
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
