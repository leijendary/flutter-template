import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/models/Product.dart';
import 'package:template/pages/cart_page.dart';
import 'package:template/utils/constants.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.iconData,
    this.circle = false,
    required this.onPressed,
  });

  final IconData iconData;
  final bool circle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconTheme = theme.iconTheme;
    final color = circle ? colorScheme.background : iconTheme.color;
    final child = IconButton(
      icon: Icon(iconData),
      color: color,
      onPressed: onPressed,
    );

    if (!circle) {
      return child;
    }

    return Padding(
      padding: const EdgeInsets.all(Spacings.extraSmallPadding),
      child: SizedBox(
        height: Sizes.iconBox,
        width: Sizes.iconBox,
        child: CircleAvatar(
          backgroundColor: colorScheme.secondary,
          child: child,
        ),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.circle = false,
  });

  final bool circle;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      iconData: Icons.arrow_back_sharp,
      circle: circle,
      onPressed: () => GoRouter.of(context).pop(),
    );
  }
}

class AppCartButton extends StatelessWidget {
  const AppCartButton({
    super.key,
    this.circle = false,
  });

  final bool circle;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      iconData: Icons.shopping_cart_outlined,
      circle: circle,
      onPressed: () => context.pushNamed(CartPage.name),
    );
  }
}

class AppFavoriteButton extends StatelessWidget {
  const AppFavoriteButton({
    super.key,
    required this.product,
    this.circle = false,
  });

  final Product product;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      iconData: Icons.favorite_outline,
      circle: circle,
      onPressed: () => print("Added to favorites!"),
    );
  }
}

class AspectRatioIconButton extends StatelessWidget {
  const AspectRatioIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Icon icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Material(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(Shapes.borderRadius),
        child: IconButton(
          color: colorScheme.onPrimary,
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class TagButton extends StatelessWidget {
  const TagButton({
    super.key,
    required this.tag,
    required this.isSelected,
    required this.onPressed,
  });

  final String tag;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final backgroundColor =
        isSelected ? colorScheme.secondary : colorScheme.surface;
    final color = isSelected ? colorScheme.onSecondary : colorScheme.onSurface;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Shapes.borderRadius),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          primary: color,
          textStyle: textTheme.labelSmall,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.extraSmallPadding,
          ),
          child: Text(tag),
        ),
      ),
    );
  }
}
