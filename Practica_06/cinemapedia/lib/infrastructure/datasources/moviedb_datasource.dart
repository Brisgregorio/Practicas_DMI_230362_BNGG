import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/infrastructure/datasources/tmdb_dio.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/domain/entities/movie_genre.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_genre_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_genre_response.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  MoviedbDatasource({required String language, required String region})
    : dio = createTmdbDio(language: language, region: region);

  final Dio dio;

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return runTmdbRequest(() async {
      final response = await dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    });
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return runTmdbRequest(() async {
      final response = await dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    });
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return runTmdbRequest(() async {
      final response = await dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    });
  }

  @override
  Future<List<MovieGenre>> getMovieGenres() async {
    return runTmdbRequest(() async {
      final response = await dio.get('/genre/movie/list');
      final genreResponse = MovieGenreResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return genreResponse.genres.map(MovieGenreMapper.toEntity).toList();
    });
  }

  @override
  Future<List<Movie>> getMoviesByGenre({
    required int genreId,
    int page = 1,
  }) async {
    return runTmdbRequest(() async {
      final response = await dio.get(
        '/discover/movie',
        queryParameters: {'with_genres': genreId, 'page': page},
      );
      return _jsonToMovies(response.data);
    });
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return runTmdbRequest(() async {
      final response = await dio.get(
        '/movie/upcoming',
        queryParameters: {'page': page},
      );
      return _jsonToMovies(response.data);
    });
  }

  @override
  Future<Movie> getMovieById(String id) async {
    return runTmdbRequest(() async {
      final response = await dio.get('/movie/$id');
      if (response.statusCode != 200) {
        throw const TmdbApiException(TmdbFailure.notFound, statusCode: 404);
      }

      final movieDetails = MovieDetails.fromJson(response.data);
      return MovieMapper.movieDetailsToEntity(movieDetails);
    });
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    return runTmdbRequest(() async {
      final response = await dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );
      return _jsonToMovies(response.data);
    });
  }
}
