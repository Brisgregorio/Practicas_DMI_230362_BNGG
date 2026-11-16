class MovieGenreResponse {
  final List<MovieGenreDb> genres;

  const MovieGenreResponse({required this.genres});

  factory MovieGenreResponse.fromJson(Map<String, dynamic> json) =>
      MovieGenreResponse(
        genres: ((json['genres'] as List<dynamic>?) ?? const [])
            .map(
              (genre) =>
                  MovieGenreDb.fromJson(genre as Map<String, dynamic>),
            )
            .toList(),
      );
}

class MovieGenreDb {
  final int id;
  final String name;

  const MovieGenreDb({required this.id, required this.name});

  factory MovieGenreDb.fromJson(Map<String, dynamic> json) => MovieGenreDb(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}