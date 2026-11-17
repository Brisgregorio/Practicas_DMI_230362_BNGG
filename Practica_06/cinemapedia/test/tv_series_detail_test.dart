import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
import 'package:cinemapedia/domain/entities/tv_series_creator.dart';
import 'package:cinemapedia/domain/entities/tv_series_organization.dart';
import 'package:cinemapedia/domain/repositories/tv_series_repository.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_providers.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:cinemapedia/presentation/screens/series/series_detail_screen.dart';
import 'package:cinemapedia/presentation/screens/series/series_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('catalog selection opens complete TV series details', (
    tester,
  ) async {
    final series = _series();
    final repository = _TestTvSeriesRepository(series);
    await _pumpSeriesApp(tester, repository);

    await tester.tap(find.text(series.name));
    await tester.pumpAndSettle();

    expect(repository.detailRequests, ['42']);
    expect(find.text('The complete story.'), findsOneWidget);
    expect(find.text('8.7'), findsOneWidget);
    expect(find.textContaining('1234 votes'), findsOneWidget);
    expect(find.text('Drama'), findsOneWidget);
    expect(find.text('First aired'), findsOneWidget);
    expect(find.text('Last aired'), findsOneWidget);
    expect(find.text('Ended'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('42'), findsOneWidget);
    expect(find.text('Creator One'), findsOneWidget);
    expect(find.text('Studio One'), findsOneWidget);
    expect(find.text('Network One'), findsOneWidget);
    expect(find.byKey(const ValueKey('favorite-series-42')), findsOneWidget);
    expect(
      tester
          .widgetList<Text>(find.byType(Text))
          .any((text) => (text.data ?? '').contains('2015')),
      isTrue,
    );
  });

  testWidgets('search result selection opens the matching series details', (
    tester,
  ) async {
    final series = _series();
    final repository = _TestTvSeriesRepository(series);
    await _pumpSeriesApp(tester, repository);

    await tester.tap(find.byKey(const ValueKey('search-tv-series')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Example');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tv-series-search-result-42')));
    await tester.pumpAndSettle();

    expect(repository.searchQueries, ['Example']);
    expect(repository.detailRequests, ['42']);
    expect(find.text('The complete story.'), findsOneWidget);
  });

  testWidgets('TV genre selection filters and Todos restores the catalog', (
    tester,
  ) async {
    final series = _series();
    final repository = _TestTvSeriesRepository(series);
    await _pumpSeriesApp(tester, repository);

    await tester.tap(find.byKey(const ValueKey('tv-genre-10759')));
    await tester.pumpAndSettle();

    expect(repository.requestedGenreIds, [10759]);
    expect(
      tester
          .widget<ChoiceChip>(find.byKey(const ValueKey('tv-genre-10759')))
          .selected,
      isTrue,
    );

    await tester.tap(find.byKey(const ValueKey('tv-genre-all')));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<ChoiceChip>(find.byKey(const ValueKey('tv-genre-all')))
          .selected,
      isTrue,
    );
    expect(repository.requestedGenreIds, [10759]);
  });

  testWidgets('missing optional detail values are not fabricated', (
    tester,
  ) async {
    final series = _series(omitOptionalDetails: true);
    await _pumpSeriesApp(
      tester,
      _TestTvSeriesRepository(series),
      initialLocation: '/series/42',
    );

    expect(find.text('First aired'), findsNothing);
    expect(find.text('Last aired'), findsNothing);
    expect(find.text('Status'), findsNothing);
    expect(find.text('Seasons'), findsNothing);
    expect(find.text('Episodes'), findsNothing);
    expect(find.text('Genres'), findsNothing);
    expect(find.text('Created by'), findsNothing);
    expect(find.text('Production companies'), findsNothing);
    expect(find.text('Networks'), findsNothing);
    expect(
      tester
          .widgetList<Text>(find.byType(Text))
          .any((text) => (text.data ?? '').contains('1970')),
      isFalse,
    );
  });

  testWidgets('series detail renders its actor, role, and cast order', (
    tester,
  ) async {
    final series = _series();
    final actor = Actor(
      id: 90,
      name: 'Cast Actor',
      profilePath: '',
      character: 'Cast Role',
      order: 3,
    );
    final repository = _TestTvSeriesRepository(series, actors: [actor]);
    await _pumpSeriesApp(
      tester,
      repository,
      initialLocation: '/series/42',
    );

    expect(find.text('Cast Actor'), findsOneWidget);
    expect(find.text('Cast Role'), findsOneWidget);
    expect(find.text('#3'), findsOneWidget);
    expect(repository.castRequests, ['42']);
  });
}

Future<void> _pumpSeriesApp(
  WidgetTester tester,
  _TestTvSeriesRepository repository, {
  String initialLocation = '/series',
}) async {
  SharedPreferences.setMockInitialValues({});
  final preferences = await SharedPreferences.getInstance();
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/series',
        builder: (context, state) => const SeriesHomeScreen(),
        routes: [
          GoRoute(
            path: ':id',
            name: SeriesDetailScreen.name,
            builder: (context, state) =>
                SeriesDetailScreen(seriesId: state.pathParameters['id']!),
          ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        tvSeriesRepositoryProvider.overrideWithValue(repository),
        popularTvSeriesProvider.overrideWith(
          (ref) async => [repository.series],
        ),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: MaterialApp.router(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

TvSeries _series({bool omitOptionalDetails = false}) => TvSeries(
  adult: false,
  backdropPath: '',
  firstAirDate: omitOptionalDetails ? null : DateTime(2015, 1, 25),
  lastAirDate: omitOptionalDetails ? null : DateTime(2019, 6, 12),
  genreIds: omitOptionalDetails ? const [] : const [18],
  genres: omitOptionalDetails
      ? const []
      : const [TvSeriesGenre(id: 18, name: 'Drama')],
  id: 42,
  originalLanguage: 'en',
  originalName: 'Example Series',
  overview: 'The complete story.',
  popularity: 12,
  posterPath: '',
  name: 'Example Series',
  status: omitOptionalDetails ? null : 'Ended',
  numberOfSeasons: omitOptionalDetails ? null : 4,
  numberOfEpisodes: omitOptionalDetails ? null : 42,
  createdBy: omitOptionalDetails
      ? const []
      : const [TvSeriesCreator(id: 1, name: 'Creator One', profilePath: null)],
  productionCompanies: omitOptionalDetails
      ? const []
      : const [
          TvSeriesOrganization(
            id: 2,
            name: 'Studio One',
            logoPath: null,
            originCountry: 'US',
          ),
        ],
  networks: omitOptionalDetails
      ? const []
      : const [
          TvSeriesOrganization(
            id: 3,
            name: 'Network One',
            logoPath: null,
            originCountry: 'US',
          ),
        ],
  voteAverage: 8.7,
  voteCount: 1234,
);

class _TestTvSeriesRepository implements TvSeriesRepository {
  final TvSeries series;
  final List<Actor> actors;
  final List<String> detailRequests = [];
  final List<String> searchQueries = [];
  final List<String> castRequests = [];
  final List<int> requestedGenreIds = [];

  _TestTvSeriesRepository(this.series, {this.actors = const []});

  @override
  Future<List<TvSeries>> getPopularSeries({int page = 1}) async => [series];

  @override
  Future<TvSeries> getSeriesById(String id) async {
    detailRequests.add(id);
    return series;
  }

  @override
  Future<List<TvSeries>> searchSeries(String query) async {
    searchQueries.add(query);
    return [series];
  }

  @override
  Future<List<Actor>> getActorsBySeries(String seriesId) async {
    castRequests.add(seriesId);
    return actors;
  }

  @override
  Future<List<TvSeriesGenre>> getSeriesGenres() async => const [
    TvSeriesGenre(id: 10759, name: 'Action & Adventure'),
  ];

  @override
  Future<List<TvSeries>> getSeriesByGenre({required int genreId, int page = 1}) async {
    requestedGenreIds.add(genreId);
    return [series];
  }
}
