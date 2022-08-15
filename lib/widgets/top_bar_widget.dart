import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/widgets/button_widget.dart';
import 'package:go_router/go_router.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    this.title = "",
    this.fancy = false,
    this.center = true,
    this.transparent = false,
    this.location = false,
    this.actions = const [],
  });

  final String title;
  final bool fancy;
  final bool center;
  final bool transparent;
  final bool location;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(Sizes.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final backgroundColor =
        transparent ? Colors.transparent : colorScheme.background;
    final style = fancy ? textTheme.titleLarge : textTheme.titleMedium;
    final leading = !GoRouter.of(context).canPop()
        ? null
        : AppBackButton(circle: transparent);

    return AppBar(
      centerTitle: center,
      backgroundColor: backgroundColor,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: style,
          ),
          _buildLocation(colorScheme, textTheme),
        ],
      ),
      leading: leading,
      actions: actions,
    );
  }

  Widget _buildLocation(ColorScheme colorScheme, TextTheme textTheme) {
    return Visibility(
      visible: location,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 0,
            child: Icon(
              Icons.location_on_outlined,
              color: colorScheme.tertiary,
              size: Sizes.labelSmallIcon,
            ),
          ),
          const Flexible(
            flex: 0,
            child: SizedBox(
              width: Spacings.iconSmallPadding,
            ),
          ),
          Text(
            "Hilltop Batangas City, Philippines",
            style: textTheme.labelSmall,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
