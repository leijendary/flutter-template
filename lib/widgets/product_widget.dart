import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:flutter_sample/pages/product_detail_page.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/image_widget.dart';
import 'package:flutter_sample/widgets/text_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          child: _buildClickable(context),
        ),
      ),
    );
  }

  Widget _buildClickable(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Shapes.borderRadius),
      child: Padding(
        padding: const EdgeInsets.all(Spacings.regularPadding),
        child: Row(
          children: [
            Flexible(
              flex: 0,
              child: ProductThumbnail(product: product),
            ),
            const Flexible(
              flex: 0,
              child: SizedBox(
                width: Spacings.tileInnerPadding,
              ),
            ),
            Flexible(
              flex: 1,
              child: ProductDetail(product: product),
            )
          ],
        ),
      ),
      onTap: () => context.router.pushNamed(
        ProductDetailPage.name,
        params: {
          "id": product.id,
        },
      ),
    );
  }
}

class ProductThumbnail extends HookConsumerWidget {
  const ProductThumbnail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uri = product.asset.thumbnail.uri ??
        product.asset.full.uri ??
        product.asset.master.uri;

    return Hero(
      tag: product.id,
      child: StorageImage(
        uri: uri,
        height: Sizes.listImageSize,
        width: Sizes.listImageSize,
      ),
    );
  }
}

class ProductDetail extends HookWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopDetail(context),
        _buildBottomDetail(context),
      ],
    );
  }

  Widget _buildTopDetail(BuildContext context) {
    return Flexible(
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
            "A cappuccino is an Italian coffee drink that is traditionally prepared with equal parts double espresso, steamed milk, and steamed milk foam.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDetail(BuildContext context) {
    // TODO: Replace with actual price
    const originalPrice = 5.95;

    return Row(
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
        FormattedPrice(
          originalPrice: originalPrice,
          style: context.theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
