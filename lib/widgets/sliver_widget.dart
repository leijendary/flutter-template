import 'package:flutter/widgets.dart';
import 'package:flutter_sample/utils/extensions.dart';

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  SliverPersistentDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

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
    return Container(
      color: context.theme.colorScheme.background,
      child: child,
    );
  }
}
