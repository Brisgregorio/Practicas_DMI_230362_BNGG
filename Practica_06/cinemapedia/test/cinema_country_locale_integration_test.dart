import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_genre.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/config/helpers/localized_country.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/main.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:cinemapedia/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
    'country selector changes interface language and persists country',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(preferences),
            movieRepositoryProvider.overrideWith(
              (ref) => _EmptyMoviesRepository(),
            ),
          ],
          child: const MainApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Inicio'), findsOneWidget);

      await tester.tap(find.byTooltip('Abrir menú'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('País e idioma de películas'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('country-US')));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(preferences.getString(selectedCinemaCountryPreferenceKey), 'US');
      expect(
        AppLocalizations.supportedLocales.map((locale) => locale.languageCode),
        contains('en'),
      );
    },
  );

  testWidgets('Chinese UI language can be selected independently of country', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      selectedCinemaCountryPreferenceKey: 'MX',
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          movieRepositoryProvider.overrideWith(
            (ref) => _EmptyMoviesRepository(),
          ),
        ],
        child: const MainApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Abrir menú'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('País e idioma de películas'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('interface-language-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('中文').last);
    await tester.pumpAndSettle();

    expect(find.text('首页'), findsOneWidget);
    expect(preferences.getString(selectedCinemaCountryPreferenceKey), 'MX');
    expect(
      preferences.getString(selectedInterfaceLanguagePreferenceKey),
      'zh',
    );
  });

  testWidgets('MainApp applies theme notifier changes globally', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        movieRepositoryProvider.overrideWith(
          (ref) => _EmptyMoviesRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MainApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!.brightness,
      Brightness.dark,
    );

    container.read(themeNotifierProvider.notifier).toggleDarkmode();
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!.brightness,
      Brightness.light,
    );
  });
}

class _EmptyMoviesRepository implements MoviesRepository {
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async => [];

  @override
  Future<List<Movie>> getPopular({int page = 1}) async => [];

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async => [];

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async => [];

  @override
  Future<List<MovieGenre>> getMovieGenres() async => [];

  @override
  Future<List<Movie>> getMoviesByGenre({required int genreId, int page = 1}) async => [];

  @override
  Future<Movie> getMovieById(String id) async =>
      throw UnsupportedError('Movie details are not part of this test.');

  @override
  Future<List<Movie>> searchMovies(String query) async => [];
}
