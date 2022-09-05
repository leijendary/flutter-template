import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/button_widget.dart';

class SearchRow extends HookWidget {
  const SearchRow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    return Padding(
      padding: const EdgeInsets.all(Spacings.regularPadding),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: AppTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: AppLocalizations.of(context)!.enterDishOrDrink,
              suffixIcon: GestureDetector(
                child: const Icon(Icons.mic),
                onTap: () => print("Microphone is on"),
              ),
            ),
          ),
          const Flexible(
            flex: 0,
            child: SizedBox(
              width: Spacings.smallPadding,
            ),
          ),
          Flexible(
            flex: 0,
            child: AspectRatioIconButton(
              icon: const Icon(Icons.tune),
              onPressed: () => print("Pressed equalizer"),
            ),
          ),
        ],
      ),
    );
  }
}

class AppTextField extends HookConsumerWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(Shapes.borderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: Spacings.fieldPadding,
          horizontal: Spacings.regularPadding,
        ),
        filled: true,
        hintText: hintText,
        hintStyle: theme.textTheme.labelSmall,
        suffixIcon: suffixIcon,
      ),
      style: theme.textTheme.labelMedium,
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
