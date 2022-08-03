import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/plugin.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _theme = ThemeData(
  colorScheme: const ColorScheme(
    background: Colors.white,
    onBackground: Colors.black,
    brightness: Brightness.light,
    surface: Colors.white,
    onSurface: Colors.black,
    primary: Color(0xffd9d9d9),
    onPrimary: Colors.black,
    secondary: Color(0xffd9d9d9),
    onSecondary: Colors.black,
    error: Colors.redAccent,
    onError: Colors.white,
  ),
  applyElevationOverlayColor: false,
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  fontFamily: 'Montserrat',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase first to catch errors that can happen on the next lines.
  await firebase();
  await dotenv.load();
  await amplify();
  await session();
  await database();

  runApp(const ProviderScope(child: App()));
}

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(sessionProvider).user.languageCode;
    final locale = useMemoized(() => Locale(languageCode), [languageCode]);

    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      locale: locale,
      supportedLocales: [locale],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: _theme,
    );
  }
}
