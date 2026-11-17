import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';

abstract class TvSeriesRepository {
  Future<List<TvSeries>> getPopularSeries({int page = 1});

  Future<TvSeries> getSeriesById(String id);

  Future<List<TvSeries>> searchSeries(String query);

  Future<List<Actor>> getActorsBySeries(String seriesId);

  Future<List<TvSeriesGenre>> getSeriesGenres();

  Future<List<TvSeries>> getSeriesByGenre({required int genreId, int page = 1});
}
