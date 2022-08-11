import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/providers/menu_provider.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/menu_widget.dart';
import 'package:flutter_sample/widgets/top_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(menuProvider);

    return CustomScrollView(
      semanticChildCount: menuState.count,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _HomePageHeader(),
        ),
        for (var menu in menuState.menus) MenuGroup(menu: menu),
      ],
    );
  }
}

class _HomePageHeader extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 150;

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
    return FractionallySizedBox(
      heightFactor: 1,
      widthFactor: 1,
      child: Container(
        color: context.theme.colorScheme.background,
        child: Column(
          children: [
            const TopBar(
              title: "Aegyo",
              fancy: true,
              center: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacings.standardPadding,
                ),
                child: _HomePageHeaderContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageHeaderContent extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Greeting(),
        Text(
          context.localizations.goodDayForCoffee,
          style: context.theme.textTheme.headlineMedium,
        ),
      ],
    );
  }
}

class _Greeting extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hour = TimeOfDay.now().hour;
    final user = ref.watch(sessionProvider).user;
    final greeting = useMemoized(() {
      String starting;

      if (hour >= 0 && hour < 12) {
        starting = context.localizations.goodMorning;
      } else if (hour >= 12 && hour < 18) {
        starting = context.localizations.goodAfternoon;
      } else {
        starting = context.localizations.goodEvening;
      }

      if (user.isGuest) {
        return "$starting.";
      }

      return "$starting, ${user.givenName}.";
    }, [hour]);

    return Text(
      greeting,
      style: context.theme.textTheme.headlineLarge,
    );
  }
}
