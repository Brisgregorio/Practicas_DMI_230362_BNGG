import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/repositories/tv_series_repository.dart';
import 'package:cinemapedia/infrastructure/mappers/tv_series_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_response.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
