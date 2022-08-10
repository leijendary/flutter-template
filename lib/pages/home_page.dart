import 'dart:math';

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
  const HomePage({Key? key}) : super(key: key);

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
        for (var menu in menuState.menus) MenuGroup(menu),
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
            const TopBar(title: "Aegyo"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacings.standardPadding,
                ),
                child: _HomePageHeaderContent(
                  shrinkOffset: shrinkOffset,
                  minExtent: minExtent,
                  maxExtent: maxExtent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageHeaderContent extends HookConsumerWidget {
  const _HomePageHeaderContent({
    required this.shrinkOffset,
    required this.minExtent,
    required this.maxExtent,
  });

  final double shrinkOffset;
  final double minExtent;
  final double maxExtent;

  static const _fontMultiplier = 12;
  static const _subHeader = "It's a good day for coffee.";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerStyle = useMemoized(() {
      return context.theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: _computeFontSize(
          context.theme.textTheme.titleLarge!.fontSize!,
        ),
      );
    }, [shrinkOffset]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Greeting(),
        Text(
          _subHeader,
          style: context.theme.textTheme.headlineMedium,
        ),
      ],
    );
  }

  double _computeFontSize(double original) {
    var limit = maxExtent - minExtent;
    var computed = min(limit, shrinkOffset) / minExtent;

    return original - (computed * _fontMultiplier);
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
        starting = "Good morning";
      } else if (hour >= 12 && hour < 18) {
        starting = "Good afternoon";
      } else {
        starting = "Good evening";
      }

      if (user.isGuest) {
        return "$starting, Angel.";
      }

      return "$starting, ${user.givenName}.";
    }, [hour]);

    return Text(
      greeting,
      style: context.theme.textTheme.headlineLarge,
    );
  }
}
