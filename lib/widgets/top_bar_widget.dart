import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/button_widget.dart';

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
    final backgroundColor =
        transparent ? Colors.transparent : context.theme.colorScheme.background;
    final style = fancy
        ? context.theme.textTheme.titleLarge
        : context.theme.textTheme.titleMedium;
    final leading = !context.router.canPop()
        ? null
        : AppBackButton(
            circle: transparent,
          );

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
          _buildLocation(context),
        ],
      ),
      leading: leading,
      actions: actions,
    );
  }

  Widget _buildLocation(BuildContext context) {
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
              color: context.theme.colorScheme.tertiary,
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
            style: context.theme.textTheme.labelSmall,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
