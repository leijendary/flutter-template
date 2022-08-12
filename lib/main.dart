import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/plugin.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff4f3328),
  onPrimary: Colors.white,
  secondary: Color(0xffd07600),
  onSecondary: Colors.white,
  tertiary: Color(0xffba782c),
  onTertiary: Colors.white,
  background: Colors.white,
  onBackground: Color(0xff040404),
  surface: Color(0xfff5f5f5),
  onSurface: Color(0xff040404),
  error: Colors.redAccent,
  onError: Colors.white,
);
final _textTheme = TextTheme(
  titleLarge: TextStyle(
    inherit: false,
    color: _colorScheme.primary,
    fontFamily: "Pacifico",
    fontSize: 24.0,
  ),
  titleMedium: TextStyle(
    inherit: false,
    color: _colorScheme.primary,
    fontFamily: "Montserrat",
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  ),
  labelMedium: const TextStyle(
    inherit: false,
    color: Color(0xff000000),
    fontFamily: "Montserrat",
    fontSize: 14.0,
    textBaseline: TextBaseline.alphabetic,
  ),
  labelSmall: const TextStyle(
    inherit: false,
    color: Color(0xff989797),
    fontFamily: "Montserrat",
    fontSize: 12.0,
    textBaseline: TextBaseline.alphabetic,
  ),
  headlineLarge: TextStyle(
    inherit: false,
    color: _colorScheme.primary,
    fontFamily: "Montserrat",
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: TextStyle(
    inherit: false,
    color: _colorScheme.primary,
    fontFamily: "Montserrat",
    fontSize: 15.0,
  ),
);
final _theme = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
  scaffoldBackgroundColor: Colors.white,
  applyElevationOverlayColor: false,
  appBarTheme: AppBarTheme(
    color: _colorScheme.onPrimary,
    foregroundColor: _colorScheme.onSurface,
    elevation: 0,
    iconTheme: IconThemeData(
      color: _colorScheme.primary,
    ),
  ),
  fontFamily: "Montserrat",
  hintColor: const Color(0xff515151),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase first to catch errors that can happen on the next lines.
  await firebase();

  // These can be loaded asynchronously
  await Future.wait([
    dotenv.load(),
    amplify(),
    database(),
  ]);

  // Session requires the database to be open
  await session();

  runApp(const ProviderScope(child: App()));
}

class App extends HookConsumerWidget {
  const App({super.key});

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
