import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    dotenv.loadFromString(envString: 'THE_MOVIEDB_KEY=test-key');
  });

  test('changing country updates TMDB language and region parameters', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final mexicoDatasource =
        container.read(movieDatasourceProvider) as MoviedbDatasource;
    expect(mexicoDatasource.dio.options.queryParameters['language'], 'es-MX');
    expect(mexicoDatasource.dio.options.queryParameters['region'], 'MX');

    final germany = cinemaCountryCatalog.singleWhere(
      (country) => country.code == 'DE',
    );
    container.read(selectedCinemaCountryProvider.notifier).state = germany;

    final germanyDatasource =
        container.read(movieDatasourceProvider) as MoviedbDatasource;
    expect(germanyDatasource, isNot(same(mexicoDatasource)));
    expect(germanyDatasource.dio.options.queryParameters['language'], 'de-DE');
    expect(germanyDatasource.dio.options.queryParameters['region'], 'DE');
    expect(germany.languageName, 'Deutsch');

    final actorRepository = container.read(actorsRepositoryProvider);
    final actorDatasource =
        actorRepository.datasource as ActorMovieDbDatasource;
    expect(actorDatasource.dio.options.queryParameters['language'], 'de-DE');
    expect(actorDatasource.dio.options.queryParameters['region'], 'DE');
  });
  test(
    'changing country reloads movie lists with the selected country',
    () async {
      final container = ProviderContainer(
        overrides: [
          movieRepositoryProvider.overrideWith(
            (ref) => _CountryMoviesRepository(
              ref.watch(selectedCinemaCountryProvider).code,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(nowPlayingMoviesProvider.notifier).loadNextPage();
      expect(container.read(nowPlayingMoviesProvider).single.title, 'MX');

      container.read(selectedCinemaCountryProvider.notifier).state =
          cinemaCountryCatalog.singleWhere((country) => country.code == 'DE');
      await Future<void>.delayed(Duration.zero);

      await container.read(nowPlayingMoviesProvider.notifier).loadNextPage();
      expect(container.read(nowPlayingMoviesProvider).single.title, 'DE');
    },
  );
}

class _CountryMoviesRepository implements MoviesRepository {
  final String countryCode;

  _CountryMoviesRepository(this.countryCode);

  List<Movie> _movies() => [
    Movie(
      adult: false,
      backdropPath: '',
      genreIds: const [],
      id: 1,
      originalLanguage: 'en',
      originalTitle: countryCode,
      overview: '',
      popularity: 0,
      posterPath: '',
      releaseDate: DateTime(2020),
      title: countryCode,
      video: false,
      voteAverage: 0,
      voteCount: 0,
    ),
  ];

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async => _movies();

  @override
  Future<List<Movie>> getPopular({int page = 1}) async => _movies();

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async => _movies();

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async => _movies();

  @override
  Future<Movie> getMovieById(String id) async => _movies().single;

  @override
  Future<List<Movie>> searchMovies(String query) async => _movies();
}
