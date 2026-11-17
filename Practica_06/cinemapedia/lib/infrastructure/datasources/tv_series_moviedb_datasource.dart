import 'package:cinemapedia/domain/datasources/tv_series_datasource.dart';
import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
import 'package:cinemapedia/infrastructure/datasources/tmdb_dio.dart';
import 'package:cinemapedia/infrastructure/mappers/tv_series_mapper.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_detail_data.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_response.dart';
import 'package:dio/dio.dart';

class TvSeriesMovieDbDatasource extends TvSeriesDatasource {
  TvSeriesMovieDbDatasource({required String language, required String region})
    : dio = createTmdbDio(language: language, region: region);

  final Dio dio;

  @override
  Future<List<TvSeries>> getPopularSeries({int page = 1}) async {
    return runTmdbRequest(() async {
      final response = await dio.get(
        '/tv/popular',
        queryParameters: {'page': page},
      );
      final seriesResponse = TvSeriesResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return seriesResponse.results.map(TvSeriesMapper.toEntity).toList();
    });
  }

  @override
  Future<TvSeries> getSeriesById(String id) async {
    return runTmdbRequest(() async {
      final response = await dio.get('/tv/$id');
      final series = TvSeriesDb.fromJson(response.data as Map<String, dynamic>);
      return TvSeriesMapper.toEntity(series);
    });
  }

  @override
  Future<List<TvSeries>> searchSeries(String query) async {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) return [];

    return runTmdbRequest(() async {
      final response = await dio.get(
        '/search/tv',
        queryParameters: {'query': normalizedQuery},
      );
      final seriesResponse = TvSeriesResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return seriesResponse.results.map(TvSeriesMapper.toEntity).toList();
    });
  }

  @override
  Future<List<Actor>> getActorsBySeries(String seriesId) async {
    return runTmdbRequest(() async {
      final response = await dio.get('/tv/$seriesId/credits');
      final credits = CreditsResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      final actors = credits.cast.map(ActorMapper.castToEntity).toList();
      actors.sort((a, b) {
        if (a.order == null) return b.order == null ? 0 : 1;
        if (b.order == null) return -1;
        return a.order!.compareTo(b.order!);
      });
      return actors;
    });
  }

  @override
  Future<List<TvSeriesGenre>> getSeriesGenres() async {
    return runTmdbRequest(() async {
      final response = await dio.get('/genre/tv/list');
      final genres = (response.data['genres'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TvSeriesGenreDb.fromJson)
          .where((genre) => genre.name.trim().isNotEmpty)
          .map((genre) => TvSeriesGenre(id: genre.id, name: genre.name))
          .toList();
      return genres;
    });
  }

  @override
  Future<List<TvSeries>> getSeriesByGenre({
    required int genreId,
    int page = 1,
  }) async {
    return runTmdbRequest(() async {
      final response = await dio.get(
        '/discover/tv',
        queryParameters: {'with_genres': genreId, 'page': page},
      );
      final seriesResponse = TvSeriesResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return seriesResponse.results.map(TvSeriesMapper.toEntity).toList();
    });
  }
}
