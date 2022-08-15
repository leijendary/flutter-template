import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/pages/sign_in_page.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/states/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppDrawer extends HookConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final user = ref.watch(sessionProvider).user;
    final isLoading = useState(false);

    ref.listen<AuthState>(authProvider, (previous, next) {
      isLoading.value = next.isLoading;
    });

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: colorScheme.primary,
            ),
            child: Text(
              user.fullName,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          if (user.isGuest)
            ListTile(
              title: const Text("Sign In"),
              onTap: () {
                GoRouter.of(context).pop();
                context.pushNamed(SignInPage.name);
              },
            ),
          if (!user.isGuest)
            ListTile(
              title: const Text("Logout"),
              onTap: isLoading.value ? null : _onTap(context, ref),
            ),
        ],
      ),
    );
  }

  VoidCallback _onTap(BuildContext context, WidgetRef ref) => () {
        GoRouter.of(context).pop();
        ref.read(authProvider.notifier).signOut();
      };
}
