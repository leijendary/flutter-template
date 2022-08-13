import 'package:flutter/material.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/widgets/drawer_widget.dart';
import 'package:flutter_sample/widgets/image_widget.dart';
import 'package:flutter_sample/widgets/input_widget.dart';
import 'package:flutter_sample/widgets/menu_widget.dart';
import 'package:flutter_sample/widgets/tag_widget.dart';
import 'package:flutter_sample/widgets/top_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          slivers: [
            SliverToBoxAdapter(
              child: _Greeting(),
            ),
            SliverPersistentHeader(
              floating: true,
              delegate: _PersistentSearchHeader(),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(Spacings.regularPadding),
                child: StorageImage(
                  uri: "promotion.png",
                  radius: Shapes.imageRadius,
                  height: Sizes.promotionHeight,
                  width: double.infinity,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(Spacings.regularPadding),
                child: TagHorizontalScroll(),
              ),
            ),
            const MenuGroupSliver(),
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
  double get maxExtent => 64;

  @override
  double get minExtent => 64;

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
      child: const Padding(
        padding: EdgeInsets.only(
          left: Spacings.regularPadding,
          top: Spacings.regularPadding,
          right: Spacings.regularPadding,
        ),
        child: SearchRow(),
      ),
    );
  }
}
