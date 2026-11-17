import 'package:cinemapedia/domain/entities/tv_series_creator.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
import 'package:cinemapedia/domain/entities/tv_series_organization.dart';

class TvSeries {
  final bool adult;
  final String backdropPath;
  final DateTime? firstAirDate;
  final DateTime? lastAirDate;
  final List<int> genreIds;
  final List<TvSeriesGenre> genres;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String name;
  final String? status;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final List<TvSeriesCreator> createdBy;
  final List<TvSeriesOrganization> productionCompanies;
  final List<TvSeriesOrganization> networks;
  final double voteAverage;
  final int voteCount;

  const TvSeries({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    this.lastAirDate,
    required this.genreIds,
    this.genres = const [],
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    this.status,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.createdBy = const [],
    this.productionCompanies = const [],
    this.networks = const [],
    required this.voteAverage,
    required this.voteCount,
  });
}
