import 'package:cinemapedia/domain/entities/tv_series.dart';

abstract class TvSeriesDatasource {
  Future<List<TvSeries>> getPopularSeries({int page = 1});

  Future<TvSeries> getSeriesById(String id);
}