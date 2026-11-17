import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
import 'package:cinemapedia/domain/repositories/tv_series_repository.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_repository_provider.dart';
import 'package:cinemapedia/presentation/screens/series/series_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('series search debounces, shows results, and can be cleared', (
    tester,
  ) async {
    final repository = _SearchTvSeriesRepository((query) async {
      return [_series(query, query == 'Dark' ? 8 : 9)];
    });
    await _pumpSeriesHome(tester, repository);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'D');
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Dark');
    await tester.pump(const Duration(milliseconds: 400));

    expect(repository.queries, isEmpty);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    expect(repository.queries, ['Dark']);
    final darkResult = find.byKey(const ValueKey('tv-series-search-result-1'));
    expect(
      find.descendant(of: darkResult, matching: find.text('Dark')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: darkResult,
        matching: find.text('A short description of Dark'),
      ),
      findsOneWidget,
    );
    final darkResultTexts = tester
        .widgetList<Text>(
          find.descendant(of: darkResult, matching: find.byType(Text)),
        )
        .map((text) => text.data ?? '')
        .toList();
    expect(darkResultTexts.any((text) => text.contains('2017')), isTrue);
    expect(find.text('8.0'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.byTooltip('Clear search'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a series name to search.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'The Bear');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(repository.queries, ['Dark', 'The Bear']);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('tv-series-search-result-2')),
        matching: find.text('The Bear'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('tv-series-search-result-1')),
      findsNothing,
    );
  });

  testWidgets('series search shows an empty-results message', (tester) async {
    final repository = _SearchTvSeriesRepository((query) async => []);
    await _pumpSeriesHome(tester, repository);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'Unmatched series');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(repository.queries, ['Unmatched series']);
    expect(find.text('No TV series were found.'), findsOneWidget);
  });

  testWidgets('series search shows errors and retries the same query', (
    tester,
  ) async {
    var requestCount = 0;
    final repository = _SearchTvSeriesRepository((query) async {
      requestCount++;
      if (requestCount == 1) throw StateError('TMDB unavailable');
      return [];
    });
    await _pumpSeriesHome(tester, repository);
    await _openSearch(tester);

    await tester.enterText(find.byType(TextField), 'Lost');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('TV series search failed.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(requestCount, 2);
    expect(find.text('No TV series were found.'), findsOneWidget);
  });
}

Future<void> _pumpSeriesHome(
  WidgetTester tester,
  TvSeriesRepository repository,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [tvSeriesRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SeriesHomeScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _openSearch(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('search-tv-series')));
  await tester.pumpAndSettle();
}

TvSeries _series(String name, double voteAverage) => TvSeries(
  adult: false,
  backdropPath: '',
  firstAirDate: DateTime(2017, 5, 15),
  genreIds: const [],
  id: name == 'Dark' ? 1 : 2,
  originalLanguage: 'en',
  originalName: name,
  overview: 'A short description of $name',
  popularity: 12,
  posterPath: 'https://example.com/poster.jpg',
  name: name,
  voteAverage: voteAverage,
  voteCount: 400,
);

class _SearchTvSeriesRepository implements TvSeriesRepository {
  final Future<List<TvSeries>> Function(String query) search;
  final List<String> queries = [];

  _SearchTvSeriesRepository(this.search);

  @override
  Future<List<TvSeries>> getPopularSeries({int page = 1}) async => [];

  @override
  Future<TvSeries> getSeriesById(String id) =>
      throw UnimplementedError('Series details are not part of this test.');

  @override
  Future<List<TvSeries>> searchSeries(String query) {
    queries.add(query);
    return search(query);
  }

  @override
  Future<List<Actor>> getActorsBySeries(String seriesId) async => [];

  @override
  Future<List<TvSeriesGenre>> getSeriesGenres() async => [];

  @override
  Future<List<TvSeries>> getSeriesByGenre({required int genreId, int page = 1}) async => [];
}
