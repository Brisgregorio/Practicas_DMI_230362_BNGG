import 'package:cinemapedia/domain/entities/tv_series.dart';

abstract class TvSeriesRepository {
  Future<List<TvSeries>> getPopularSeries({int page = 1});

  Future<TvSeries> getSeriesById(String id);
}