import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_response.dart';

class TvSeriesMapper {
  static TvSeries toEntity(TvSeriesDb series) => TvSeries(
    adult: series.adult,
    backdropPath: _imagePath(series.backdropPath),
    firstAirDate: series.firstAirDate,
    genreIds: series.genreIds,
    id: series.id,
    originalLanguage: series.originalLanguage,
    originalName: series.originalName,
    overview: series.overview,
    popularity: series.popularity,
    posterPath: _imagePath(series.posterPath),
    name: series.name,
    voteAverage: series.voteAverage,
    voteCount: series.voteCount,
  );

  static String _imagePath(String path) => path.isEmpty
      ? 'https://www.movienewz.com/img/films/poster-holder.jpg'
      : 'https://image.tmdb.org/t/p/w500$path';
}