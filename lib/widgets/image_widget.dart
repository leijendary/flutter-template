import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sample/providers/menu_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StorageImage extends ConsumerWidget {
  const StorageImage({
    super.key,
    this.cacheKey,
    required this.uri,
    this.height,
    this.width = double.infinity,
    this.radius = 0,
  });

  final String? cacheKey;
  final String? uri;
  final double? height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultImage = Image.asset(
      Assets.thumbnailDefault,
      height: height,
      width: width,
    );

    if (uri == null) {
      return defaultImage;
    }

    final urlWatch = ref.watch(menuUrlProvider(uri!));

    return urlWatch.when(
      data: (data) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          cacheKey: cacheKey,
          height: height,
          width: width,
          imageUrl: data,
          fit: BoxFit.cover,
          placeholder: (context, url) => defaultImage,
          errorWidget: (context, url, error) => defaultImage,
          fadeInDuration: Durations.fadeDuration,
        ),
      ),
      loading: () => defaultImage,
      error: (error, stackTrace) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace);

        return defaultImage;
      },
    );
  }
}
