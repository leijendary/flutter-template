import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:template/providers/menu_provider.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/button_widget.dart';
import 'package:template/widgets/drawer_widget.dart';
import 'package:template/widgets/image_widget.dart';
import 'package:template/widgets/input_widget.dart';
import 'package:template/widgets/menu_widget.dart';
import 'package:template/widgets/sliver_widget.dart';
import 'package:template/widgets/tag_widget.dart';
import 'package:template/widgets/text_widget.dart';
import 'package:template/widgets/top_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: const AppTopBar(
          title: "Aegyo",
          fancy: true,
          center: true,
          location: true,
          actions: [
            AppCartButton(),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            _buildGreeting(),
            _buildSearch(),
            _buildPromotion(),
            _buildTag(),
            _buildMenuGroup(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return const SliverToBoxAdapter(
      child: Greeting(),
    );
  }

  Widget _buildSearch() {
    return SliverPersistentHeader(
      floating: true,
      delegate: SliverPersistentDelegate(
        minHeight: Sizes.searchRowHeight,
        maxHeight: Sizes.searchRowHeight,
        child: const SearchRow(),
      ),
    );
  }

  Widget _buildPromotion() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: Spacings.regularPadding,
          right: Spacings.regularPadding,
          bottom: Spacings.regularPadding,
        ),
        child: StorageImage(
          uri: "promotion.png",
          radius: Shapes.imageRadius,
          height: Sizes.promotionHeight,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildTag() {
    return const SliverToBoxAdapter(
      child: TagHorizontalScroll(),
    );
  }

  Widget _buildMenuGroup() {
    return Consumer(
      builder: (context, ref, child) {
        final menuState = ref.watch(menuProvider);

        return MultiSliver(
          children: [
            for (var menu in menuState.menus)
              MenuGroup(
                key: Key(menu.id),
                menu: menu,
              ),
          ],
        );
      },
    );
  }
}
