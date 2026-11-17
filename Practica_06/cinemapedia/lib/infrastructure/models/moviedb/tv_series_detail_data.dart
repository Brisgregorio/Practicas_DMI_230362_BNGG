class TvSeriesGenreDb {
  final int id;
  final String name;

  const TvSeriesGenreDb({required this.id, required this.name});

  factory TvSeriesGenreDb.fromJson(Map<String, dynamic> json) =>
      TvSeriesGenreDb(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String? ?? '',
      );
}

class TvSeriesCreatorDb {
  final int? id;
  final String name;
  final String? profilePath;

  const TvSeriesCreatorDb({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory TvSeriesCreatorDb.fromJson(Map<String, dynamic> json) =>
      TvSeriesCreatorDb(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String? ?? '',
        profilePath: json['profile_path'] as String?,
      );
}

class TvSeriesOrganizationDb {
  final int? id;
  final String name;
  final String? logoPath;
  final String? originCountry;

  const TvSeriesOrganizationDb({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory TvSeriesOrganizationDb.fromJson(Map<String, dynamic> json) =>
      TvSeriesOrganizationDb(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String? ?? '',
        logoPath: json['logo_path'] as String?,
        originCountry: json['origin_country'] as String?,
      );
}
