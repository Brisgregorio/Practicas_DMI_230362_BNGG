import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/tv_series_creator.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
import 'package:cinemapedia/domain/entities/tv_series_organization.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_detail_data.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_response.dart';

class TvSeriesMapper {
  static TvSeries toEntity(TvSeriesDb series) => TvSeries(
    adult: series.adult,
    backdropPath: _optionalImagePath(series.backdropPath) ?? '',
    firstAirDate: series.firstAirDate,
    lastAirDate: series.lastAirDate,
    genreIds: series.genreIds,
    genres: series.genres
        .map((genre) => TvSeriesGenre(id: genre.id, name: genre.name))
        .toList(),
    id: series.id,
    originalLanguage: series.originalLanguage,
    originalName: series.originalName,
    overview: series.overview,
    popularity: series.popularity,
    posterPath:
        _optionalImagePath(series.posterPath) ??
        'https://www.movienewz.com/img/films/poster-holder.jpg',
    name: series.name,
    status: series.status,
    numberOfSeasons: series.numberOfSeasons,
    numberOfEpisodes: series.numberOfEpisodes,
    createdBy: series.createdBy
        .map(
          (creator) => TvSeriesCreator(
            id: creator.id,
            name: creator.name,
            profilePath: _optionalImagePath(creator.profilePath),
          ),
        )
        .toList(),
    productionCompanies: series.productionCompanies
        .map(_organizationToEntity)
        .toList(),
    networks: series.networks.map(_organizationToEntity).toList(),
    voteAverage: series.voteAverage,
    voteCount: series.voteCount,
  );

  static String? _optionalImagePath(String? path) =>
      path == null || path.isEmpty
      ? null
      : 'https://image.tmdb.org/t/p/w500$path';

  static TvSeriesOrganization _organizationToEntity(
    TvSeriesOrganizationDb organization,
  ) => TvSeriesOrganization(
    id: organization.id,
    name: organization.name,
    logoPath: _optionalImagePath(organization.logoPath),
    originCountry: organization.originCountry,
  );
}
