import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/config/helpers/localized_country.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';

Future<void> _countryPersistence = Future<void>.value();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final preferences = await SharedPreferences.getInstance();
  final selectedCountry = loadSelectedCinemaCountry(preferences);
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        selectedCinemaCountryProvider.overrideWith((ref) => selectedCountry),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(sharedPreferencesProvider);
    final selectedCountry = ref.watch(selectedCinemaCountryProvider);

    ref.listen(selectedCinemaCountryProvider, (previous, next) {
      if (previous?.code == next.code) return;
      _countryPersistence = _countryPersistence.then(
        (_) => _persistSelectedCountry(preferences, next),
      );
    });

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      locale: interfaceLocaleForCountry(selectedCountry),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}

Future<void> _persistSelectedCountry(
  SharedPreferences preferences,
  CinemaCountry country,
) async {
  try {
    await saveSelectedCinemaCountry(preferences, country);
  } on Object catch (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'country preference persistence',
      ),
    );
  }
}
