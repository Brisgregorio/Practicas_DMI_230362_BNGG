import 'package:cinemapedia/domain/datasources/tv_series_datasource.dart';
import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
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

  @override
  Future<List<TvSeries>> searchSeries(String query) {
    return datasource.searchSeries(query);
  }

  @override
  Future<List<Actor>> getActorsBySeries(String seriesId) {
    return datasource.getActorsBySeries(seriesId);
  }

  @override
  Future<List<TvSeriesGenre>> getSeriesGenres() {
    return datasource.getSeriesGenres();
  }

  @override
  Future<List<TvSeries>> getSeriesByGenre({
    required int genreId,
    int page = 1,
  }) {
    return datasource.getSeriesByGenre(genreId: genreId, page: page);
  }
}
