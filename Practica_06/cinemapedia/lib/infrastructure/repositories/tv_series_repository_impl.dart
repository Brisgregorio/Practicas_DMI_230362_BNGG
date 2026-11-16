import 'package:cinemapedia/domain/datasources/tv_series_datasource.dart';
import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesDatasource datasource;

  TvSeriesRepositoryImpl(this.datasource);

  @override
  Future<List<TvSeries>> getPopularSeries({int page = 1}) {
    return datasource.getPopularSeries(page: page);
  }

  @override
  Future<TvSeries> getSeriesById(String id) {
    return datasource.getSeriesById(id);
  }
}