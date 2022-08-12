import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            Shapes.borderRadius,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacings.regularPadding,
        ),
        filled: true,
        isCollapsed: true,
        hintText: hintText,
        hintStyle: context.theme.textTheme.labelSmall,
        suffixIcon: suffixIcon,
      ),
      style: context.theme.textTheme.labelMedium,
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
