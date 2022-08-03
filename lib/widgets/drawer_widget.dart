import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/sign_in_page.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider).user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
            ),
            child: Text(
              user.fullName,
              style: context.theme.textTheme.titleLarge,
            ),
          ),
          if (user.isGuest)
            ListTile(
              title: const Text("Sign In"),
              onTap: () {
                context.navigator.pop();
                context.pushNamed(SignInPage.name);
              },
            ),
          if (!user.isGuest)
            ListTile(
              title: const Text("Logout"),
              onTap: _onTap(context, ref),
            ),
        ],
      ),
    );
  }

  GestureTapCallback? _onTap(
    BuildContext context,
    WidgetRef ref,
  ) =>
      ref.watch(authProvider).maybeWhen(
            loading: null,
            orElse: () {
              return () {
                context.navigator.pop();
                ref.read(authProvider.notifier).signOut();
              };
            },
          );
}
