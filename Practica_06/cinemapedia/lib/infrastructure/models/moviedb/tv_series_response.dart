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
  final DateTime firstAirDate;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String name;
  final double voteAverage;
  final int voteCount;

  const TvSeriesDb({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvSeriesDb.fromJson(Map<String, dynamic> json) {
    final listGenreIds = json['genre_ids'] as List<dynamic>?;
    final detailedGenres = json['genres'] as List<dynamic>?;
    final genreIds = listGenreIds != null
        ? listGenreIds.map((id) => (id as num).toInt()).toList()
        : (detailedGenres ?? const [])
              .map((genre) => (genre['id'] as num).toInt())
              .toList();
    final date = (json['first_air_date'] as String?) ?? '';

    return TvSeriesDb(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String? ?? '',
      firstAirDate: DateTime.tryParse(date) ?? DateTime(1970),
      genreIds: genreIds,
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String? ?? '',
      originalName:
          json['original_name'] as String? ?? json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      posterPath: json['poster_path'] as String? ?? '',
      name: json['name'] as String? ?? json['original_name'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }
}