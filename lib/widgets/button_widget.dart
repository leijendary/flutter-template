import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';

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
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Material(
        color: context.theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(Shapes.borderRadius),
        child: IconButton(
          color: context.theme.colorScheme.onPrimary,
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
    final backgroundColor = isSelected
        ? context.theme.colorScheme.secondary
        : context.theme.colorScheme.surface;
    final color = isSelected
        ? context.theme.colorScheme.onSecondary
        : context.theme.colorScheme.onSurface;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Shapes.borderRadius),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          primary: color,
          textStyle: context.theme.textTheme.labelSmall,
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
