import 'package:flutter/material.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:flutter_sample/repositories/product_repository.dart';
import 'package:flutter_sample/utils/constants.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentDelegate(
              minHeight: Sizes.detailImageMinHeight,
              maxHeight: Sizes.detailImageMaxHeight,
              child: Container(
                color: colorScheme.primary,
                child: Stack(
                  children: [
                    Hero(
                      tag: product.id,
                      child: StorageImage(uri: uri),
                    ),
                    _buildAppBar(product),
                    _buildDetail(product, colorScheme, textTheme),
                    _buildCorner(colorScheme.background),
                  ],
                ),
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

  Widget _buildDetail(
    Product product,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacings.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                _buildName(product, colorScheme, textTheme),
                _buildPrice(product),
              ],
            ),
            const SizedBox(height: Spacings.regularIsolation),
          ],
        ),
      ),
    );
  }

  Widget _buildName(
    Product product,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: textTheme.displayLarge?.copyWith(
              color: colorScheme.onSecondary,
              shadows: Shadows.standardText,
            ),
          ),
          Text(
            "with oat milk",
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onSecondary,
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

  Widget _buildCorner(Color color) {
    return Positioned(
      bottom: -1,
      left: 0,
      right: 0,
      child: Container(
        height: Sizes.cornerHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Shapes.containerRadius),
          ),
        ),
      ),
    );
  }
}
