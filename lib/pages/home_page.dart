import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/providers/menu_provider.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/drawer_widget.dart';
import 'package:flutter_sample/widgets/input_widget.dart';
import 'package:flutter_sample/widgets/menu_widget.dart';
import 'package:flutter_sample/widgets/top_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(menuProvider);

    return GestureDetector(
      onTap: () => context.focusScope.unfocus(),
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: const AppTopBar(
          title: "Aegyo",
          fancy: true,
          center: true,
        ),
        body: CustomScrollView(
          semanticChildCount: menuState.count,
          slivers: [
            SliverToBoxAdapter(
              child: _Greeting(),
            ),
            SliverPersistentHeader(
              floating: true,
              delegate: _PersistentSearchHeader(),
            ),
            for (var menu in menuState.menus) MenuGroup(menu: menu),
          ],
        ),
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Spacings.regularPadding,
        top: Spacings.largePadding,
        right: Spacings.regularPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final hour = TimeOfDay.now().hour;
              final user = ref.watch(sessionProvider).user;
              final String greeting;
              final String starting;

              if (hour >= 0 && hour < 12) {
                starting = context.localizations.goodMorning;
              } else if (hour >= 12 && hour < 18) {
                starting = context.localizations.goodAfternoon;
              } else {
                starting = context.localizations.goodEvening;
              }

              if (user.isGuest) {
                greeting = "$starting, Angel.";
              } else {
                greeting = "$starting, ${user.givenName}.";
              }

              return Text(
                greeting,
                style: context.theme.textTheme.headlineLarge,
              );
            },
          ),
          Text(
            context.localizations.goodDayForCoffee,
            style: context.theme.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}

class _PersistentSearchHeader extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

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
      child: Padding(
        padding: const EdgeInsets.all(Spacings.regularPadding),
        child: _SearchRow(),
      ),
    );
  }
}

class _SearchRow extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    return Row(
      children: [
        Flexible(
          flex: 1,
          child: AppTextField(
            controller: controller,
            focusNode: focusNode,
            hintText: context.localizations.enterDishOrDrink,
            suffixIcon: IconButton(
              iconSize: Sizes.inputIconHeight,
              color: context.theme.hintColor,
              icon: const Icon(Icons.mic),
              onPressed: () => print("pressed"),
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: Spacings.smallPadding),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Material(
                color: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(Shapes.borderRadius),
                child: IconButton(
                  color: context.theme.colorScheme.onPrimary,
                  icon: const Icon(Icons.tune),
                  onPressed: () => print("Pressed equalizer"),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
