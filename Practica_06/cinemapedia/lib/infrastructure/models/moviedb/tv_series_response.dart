import 'package:cinemapedia/infrastructure/models/moviedb/tv_series_detail_data.dart';

class TvSeriesResponse {
  final List<TvSeriesDb> results;

  const TvSeriesResponse({required this.results});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        results: ((json['results'] as List<dynamic>?) ?? const [])
            .map((item) => TvSeriesDb.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

class TvSeriesDb {
  final bool adult;
  final String backdropPath;
  final DateTime? firstAirDate;
  final DateTime? lastAirDate;
  final List<int> genreIds;
  final List<TvSeriesGenreDb> genres;
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
  final List<TvSeriesCreatorDb> createdBy;
  final List<TvSeriesOrganizationDb> productionCompanies;
  final List<TvSeriesOrganizationDb> networks;
  final double voteAverage;
  final int voteCount;

  const TvSeriesDb({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.genreIds,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.status,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.createdBy,
    required this.productionCompanies,
    required this.networks,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvSeriesDb.fromJson(Map<String, dynamic> json) {
    final genres = _parseObjects(json['genres'])
        .where(_hasIdAndName)
        .map(TvSeriesGenreDb.fromJson)
        .toList();
    final listGenreIds = json['genre_ids'];
    final genreIds = listGenreIds is List
        ? listGenreIds.whereType<num>().map((id) => id.toInt()).toList()
        : <int>[];
    final firstAirDate = _parseDate(json['first_air_date']);

    return TvSeriesDb(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String? ?? '',
      firstAirDate: firstAirDate,
      lastAirDate: _parseDate(json['last_air_date']),
      genreIds: genreIds.isNotEmpty
          ? genreIds
          : genres.map((genre) => genre.id).toList(),
      genres: genres,
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String? ?? '',
      originalName:
          json['original_name'] as String? ?? json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      posterPath: json['poster_path'] as String? ?? '',
      name: json['name'] as String? ?? json['original_name'] as String? ?? '',
      status: json['status'] as String?,
      numberOfSeasons: (json['number_of_seasons'] as num?)?.toInt(),
      numberOfEpisodes: (json['number_of_episodes'] as num?)?.toInt(),
      createdBy: _parseObjects(json['created_by'])
          .where(_hasName)
          .map(TvSeriesCreatorDb.fromJson)
          .toList(),
      productionCompanies: _parseObjects(json['production_companies'])
          .where(_hasName)
          .map(TvSeriesOrganizationDb.fromJson)
          .toList(),
      networks: _parseObjects(json['networks'])
          .where(_hasName)
          .map(TvSeriesOrganizationDb.fromJson)
          .toList(),
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}

DateTime? _parseDate(Object? value) {
  if (value is! String || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

List<Map<String, dynamic>> _parseObjects(Object? value) {
  if (value is! List) return const [];
  return value.whereType<Map<String, dynamic>>().toList();
}

bool _hasIdAndName(Map<String, dynamic> json) =>
    json['id'] is num && _hasName(json);

bool _hasName(Map<String, dynamic> json) =>
    json['name'] is String && (json['name'] as String).trim().isNotEmpty;
