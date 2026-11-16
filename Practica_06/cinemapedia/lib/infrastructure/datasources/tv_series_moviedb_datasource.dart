import 'package:cinemapedia/domain/datasources/tv_series_datasource.dart';
import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/infrastructure/datasources/tmdb_dio.dart';
import 'package:cinemapedia/infrastructure/mappers/tv_series_mapper.dart';
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
}
