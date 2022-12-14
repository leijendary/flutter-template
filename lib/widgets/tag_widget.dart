import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/providers/menu_provider.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/button_widget.dart';

class TagHorizontalScroll extends HookConsumerWidget {
  const TagHorizontalScroll({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(menuProvider);
    final tag = useState(menuState.tags[0]);

    return Padding(
      padding: const EdgeInsets.all(Spacings.regularPadding),
      child: SizedBox(
        height: Sizes.tagButtonHeight,
        child: ListView.separated(
          itemCount: menuState.tags.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TagButton(
              tag: menuState.tags[index],
              isSelected: tag.value == menuState.tags[index],
              onPressed: () {
                tag.value = menuState.tags[index];

                ref.read(menuProvider.notifier).list(tag: tag.value);
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: Spacings.smallPadding,
            );
          },
        ),
      ),
    );
  }
}
