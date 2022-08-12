import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/Product.dart';
import 'package:flutter_sample/providers/menu_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final _defaultImage = Image.asset(
  Assets.thumbnailDefault,
  height: Sizes.listImageSize,
  width: Sizes.listImageSize,
);

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
            onTap: () {},
          ),
        ),
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

    if (uri == null) {
      return _defaultImage;
    }

    final urlWatch = ref.watch(menuUrlProvider(uri));

    return urlWatch.when(
      data: (data) => CachedNetworkImage(
        cacheKey: product.id,
        height: Sizes.listImageSize,
        width: Sizes.listImageSize,
        imageUrl: data,
        placeholder: (context, url) => _defaultImage,
        errorWidget: (context, url, error) => _defaultImage,
        fadeInDuration: Durations.fadeDuration,
      ),
      loading: () => _defaultImage,
      error: (error, stackTrace) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace);

        return _defaultImage;
      },
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
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: context.theme.colorScheme.secondary,
                ),
                const Text("5.0")
              ],
            ),
            Text(
              price,
              style: context.theme.textTheme.labelMedium,
            ),
          ],
        )
      ],
    );
  }
}
