import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
import 'package:cinemapedia/domain/repositories/tv_series_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/tv_series_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/mappers/tv_series_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_response.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    dotenv.loadFromString(envString: 'THE_MOVIEDB_KEY=test-key');
  });

  test('TMDB series data maps list and detail genre shapes', () {
    final listedSeries = TvSeriesDb.fromJson(_seriesListJson());
    final detailedSeries = TvSeriesDb.fromJson({
      ..._seriesListJson(),
      'genre_ids': null,
      'genres': [
        {'id': 10759, 'name': 'Action & Adventure'},
      ],
    });

    expect(TvSeriesMapper.toEntity(listedSeries).name, 'Serie de prueba');
    expect(TvSeriesMapper.toEntity(listedSeries).genreIds, [10759]);
    expect(TvSeriesMapper.toEntity(detailedSeries).genreIds, [10759]);
    expect(
      TvSeriesMapper.toEntity(listedSeries).posterPath,
      'https://image.tmdb.org/t/p/w500/poster.jpg',
    );
    expect(TvSeriesMapper.toEntity(listedSeries).lastAirDate, isNull);
    expect(TvSeriesMapper.toEntity(listedSeries).status, isNull);
    expect(TvSeriesMapper.toEntity(listedSeries).genres, isEmpty);
    expect(TvSeriesMapper.toEntity(listedSeries).createdBy, isEmpty);
    expect(TvSeriesMapper.toEntity(listedSeries).networks, isEmpty);
  });

  test('TV detail fields and nested TMDB objects map to the entity', () {
    final details = TvSeriesMapper.toEntity(
      TvSeriesDb.fromJson({
        ..._seriesListJson(),
        'genre_ids': null,
        'genres': [
          {'id': 18, 'name': 'Drama'},
        ],
        'last_air_date': '2024-06-15',
        'status': 'Ended',
        'number_of_seasons': 5,
        'number_of_episodes': 62,
        'created_by': [
          {'id': 7, 'name': 'Creadora', 'profile_path': '/creator.jpg'},
        ],
        'production_companies': [
          {
            'id': 12,
            'name': 'Productora',
            'logo_path': '/production.png',
            'origin_country': 'MX',
          },
        ],
        'networks': [
          {
            'id': 23,
            'name': 'Cadena',
            'logo_path': '/network.png',
            'origin_country': 'US',
          },
        ],
      }),
    );

    expect(details.lastAirDate, DateTime(2024, 6, 15));
    expect(details.status, 'Ended');
    expect(details.numberOfSeasons, 5);
    expect(details.numberOfEpisodes, 62);
    expect(details.genres.single.name, 'Drama');
    expect(details.genreIds, [18]);
    expect(details.createdBy.single.name, 'Creadora');
    expect(
      details.createdBy.single.profilePath,
      'https://image.tmdb.org/t/p/w500/creator.jpg',
    );
    expect(details.productionCompanies.single.name, 'Productora');
    expect(
      details.productionCompanies.single.logoPath,
      'https://image.tmdb.org/t/p/w500/production.png',
    );
    expect(details.productionCompanies.single.originCountry, 'MX');
    expect(details.networks.single.name, 'Cadena');
    expect(
      details.networks.single.logoPath,
      'https://image.tmdb.org/t/p/w500/network.png',
    );
  });

  test('optional TV detail fields handle null TMDB values', () {
    final series = TvSeriesMapper.toEntity(
      TvSeriesDb.fromJson({
        ..._seriesListJson(),
        'first_air_date': null,
        'last_air_date': null,
        'status': null,
        'number_of_seasons': null,
        'number_of_episodes': null,
        'genres': [
          null,
          {'id': null, 'name': null},
        ],
        'created_by': [
          null,
          {'id': null, 'name': null},
        ],
        'production_companies': [
          null,
          {'id': null, 'name': null},
        ],
        'networks': [
          null,
          {'id': null, 'name': null},
        ],
      }),
    );

    expect(series.firstAirDate, isNull);
    expect(series.lastAirDate, isNull);
    expect(series.status, isNull);
    expect(series.numberOfSeasons, isNull);
    expect(series.numberOfEpisodes, isNull);
    expect(series.genres, isEmpty);
    expect(series.createdBy, isEmpty);
    expect(series.productionCompanies, isEmpty);
    expect(series.networks, isEmpty);
  });

  test(
    'TV series search uses TMDB search endpoint and selected locale',
    () async {
      final datasource = TvSeriesMovieDbDatasource(
        language: 'ja-JP',
        region: 'JP',
      );
      final adapter = _SearchTvSeriesAdapter();
      datasource.dio.httpClientAdapter = adapter;

      final results = await datasource.searchSeries('  Serie de prueba  ');

      expect(results.single.name, 'Serie de prueba');
      expect(adapter.requestCount, 1);
      expect(adapter.lastOptions?.path, '/search/tv');
      expect(adapter.lastOptions?.queryParameters['query'], 'Serie de prueba');
      expect(adapter.lastOptions?.queryParameters['language'], 'ja-JP');
      expect(adapter.lastOptions?.queryParameters['region'], 'JP');
      expect(await datasource.searchSeries('   '), isEmpty);
      expect(adapter.requestCount, 1);
    },
  );

  test('TV details use the ID endpoint and selected locale', () async {
    final datasource = TvSeriesMovieDbDatasource(
      language: 'es-MX',
      region: 'MX',
    );
    final adapter = _TvSeriesDetailAdapter({
      ..._seriesListJson(),
      'genre_ids': null,
      'genres': [
        {'id': 18, 'name': 'Drama'},
      ],
      'status': 'Ended',
      'number_of_seasons': 4,
      'number_of_episodes': 42,
    });
    datasource.dio.httpClientAdapter = adapter;

    final details = await datasource.getSeriesById('8');

    expect(details.genres.single.name, 'Drama');
    expect(details.numberOfSeasons, 4);
    expect(details.numberOfEpisodes, 42);
    expect(adapter.lastOptions?.path, '/tv/8');
    expect(adapter.lastOptions?.queryParameters['language'], 'es-MX');
    expect(adapter.lastOptions?.queryParameters['region'], 'MX');
  });

  test('TV cast uses its own credits endpoint and maps participation data', () async {
    final datasource = TvSeriesMovieDbDatasource(
      language: 'pt-BR',
      region: 'BR',
    );
    final adapter = _TvSeriesDetailAdapter({
      'id': 42,
      'cast': [
        {
          'adult': false,
          'gender': 1,
          'id': 99,
          'known_for_department': 'Acting',
          'name': 'Actor One',
          'original_name': 'Actor One',
          'popularity': 5.5,
          'profile_path': '/actor.jpg',
          'cast_id': 1,
          'character': 'Character One',
          'credit_id': 'credit-1',
          'order': 2,
        },
      ],
      'crew': [],
    });
    datasource.dio.httpClientAdapter = adapter;

    final actors = await datasource.getActorsBySeries('42');

    expect(adapter.lastOptions?.path, '/tv/42/credits');
    expect(adapter.lastOptions?.queryParameters['language'], 'pt-BR');
    expect(adapter.lastOptions?.queryParameters['region'], 'BR');
    expect(actors.single.name, 'Actor One');
    expect(actors.single.character, 'Character One');
    expect(actors.single.order, 2);
    expect(
      actors.single.profilePath,
      'https://image.tmdb.org/t/p/w500/actor.jpg',
    );
  });

  test('TV genres and discovery use TV endpoints and TV genre IDs', () async {
    final datasource = TvSeriesMovieDbDatasource(
      language: 'de-DE',
      region: 'DE',
    );
    final genresAdapter = _TvSeriesDetailAdapter({
      'genres': [
        {'id': 10759, 'name': 'Action & Adventure'},
      ],
    });
    datasource.dio.httpClientAdapter = genresAdapter;

    final genres = await datasource.getSeriesGenres();

    expect(genres.single.id, 10759);
    expect(genresAdapter.lastOptions?.path, '/genre/tv/list');
    expect(genresAdapter.lastOptions?.queryParameters['language'], 'de-DE');
    expect(genresAdapter.lastOptions?.queryParameters['region'], 'DE');

    final discoveryAdapter = _TvSeriesDetailAdapter({
      'results': [_seriesListJson()],
    });
    datasource.dio.httpClientAdapter = discoveryAdapter;

    final results = await datasource.getSeriesByGenre(genreId: genres.single.id);

    expect(results.single.id, 8);
    expect(discoveryAdapter.lastOptions?.path, '/discover/tv');
    expect(discoveryAdapter.lastOptions?.queryParameters['with_genres'], 10759);
    expect(discoveryAdapter.lastOptions?.queryParameters['language'], 'de-DE');
    expect(discoveryAdapter.lastOptions?.queryParameters['region'], 'DE');
  });

  test('popular series provider returns repository results', () async {
    final container = ProviderContainer(
      overrides: [
        tvSeriesRepositoryProvider.overrideWithValue(_TestTvSeriesRepository()),
      ],
    );
    addTearDown(container.dispose);

    final popularSeries = await container.read(popularTvSeriesProvider.future);
    expect(popularSeries.single.name, 'Serie de prueba');
  });
}

class _TestTvSeriesRepository implements TvSeriesRepository {
  @override
  Future<List<TvSeries>> getPopularSeries({int page = 1}) async => [
    TvSeries(
      adult: false,
      backdropPath: '',
      firstAirDate: DateTime(2020),
      genreIds: const [10759],
      id: 8,
      originalLanguage: 'es',
      originalName: 'Serie original',
      overview: 'Sinopsis',
      popularity: 12,
      posterPath: '',
      name: 'Serie de prueba',
      voteAverage: 8.1,
      voteCount: 30,
    ),
  ];

  @override
  Future<TvSeries> getSeriesById(String id) async =>
      (await getPopularSeries()).single;

  @override
  Future<List<TvSeries>> searchSeries(String query) async =>
      (await getPopularSeries());

  @override
  Future<List<Actor>> getActorsBySeries(String seriesId) async => [];

  @override
  Future<List<TvSeriesGenre>> getSeriesGenres() async => [];

  @override
  Future<List<TvSeries>> getSeriesByGenre({required int genreId, int page = 1}) async => [];
}

Map<String, dynamic> _seriesListJson() => {
  'adult': false,
  'backdrop_path': '/backdrop.jpg',
  'first_air_date': '2020-03-10',
  'genre_ids': [10759],
  'id': 8,
  'original_language': 'es',
  'original_name': 'Serie original',
  'overview': 'Sinopsis',
  'popularity': 12,
  'poster_path': '/poster.jpg',
  'name': 'Serie de prueba',
  'vote_average': 8.1,
  'vote_count': 30,
};

class _SearchTvSeriesAdapter implements HttpClientAdapter {
  int requestCount = 0;
  RequestOptions? lastOptions;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    lastOptions = options;
    return ResponseBody.fromString(
      jsonEncode({
        'results': [_seriesListJson()],
      }),
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json; charset=utf-8'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _TvSeriesDetailAdapter implements HttpClientAdapter {
  final Map<String, dynamic> response;
  RequestOptions? lastOptions;

  _TvSeriesDetailAdapter(this.response);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastOptions = options;
    return ResponseBody.fromString(
      jsonEncode(response),
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json; charset=utf-8'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
