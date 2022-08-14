import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:flutter_sample/repositories/product_repository.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/button_widget.dart';
import 'package:flutter_sample/widgets/image_widget.dart';
import 'package:flutter_sample/widgets/sliver_widget.dart';
import 'package:flutter_sample/widgets/text_widget.dart';
import 'package:flutter_sample/widgets/top_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailPage extends HookConsumerWidget {
  const ProductDetailPage({
    super.key,
    required this.id,
  });

  static const name = "product-detail";
  static const path = "/products/:id";

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.read(productRepositoryProvider).get(id);
    final uri = product.asset.master.uri ??
        product.asset.full.uri ??
        product.asset.thumbnail.uri;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentDelegate(
              minHeight: Sizes.detailImageMinHeight,
              maxHeight: Sizes.detailImageMaxHeight,
              child: Stack(
                children: [
                  Hero(
                    tag: product.id,
                    child: StorageImage(uri: uri),
                  ),
                  _buildAppBar(product),
                  _buildDetail(context, product),
                  _buildCorner(context),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(Spacings.regularPadding),
            sliver: SliverToBoxAdapter(
              child: Text("Hello"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(Product product) {
    return Padding(
      padding: const EdgeInsets.all(Spacings.smallPadding),
      child: AppTopBar(
        transparent: true,
        actions: [
          AppFavoriteButton(
            product: product,
            circle: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context, Product product) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacings.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                _buildName(context, product),
                _buildPrice(product),
              ],
            ),
            const SizedBox(height: Spacings.regularIsolation),
          ],
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context, Product product) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: context.theme.textTheme.displayLarge?.copyWith(
              color: context.theme.colorScheme.onSecondary,
              shadows: Shadows.standardText,
            ),
          ),
          Text(
            "with oat milk",
            style: context.theme.textTheme.labelMedium?.copyWith(
              color: context.theme.colorScheme.onSecondary,
              shadows: Shadows.standardText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice(Product product) {
    // TODO: Replace with actual price
    const originalPrice = 5.95;

    return const Flexible(
      flex: 0,
      child: FormattedPriceTag(originalPrice: originalPrice),
    );
  }

  Widget _buildCorner(BuildContext context) {
    return Positioned(
      bottom: -1,
      left: 0,
      right: 0,
      child: Container(
        height: Sizes.cornerHeight,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Shapes.containerRadius),
          ),
        ),
      ),
    );
  }
}
