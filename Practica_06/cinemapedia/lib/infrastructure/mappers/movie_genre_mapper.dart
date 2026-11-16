import 'package:cinemapedia/domain/entities/movie_genre.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_genre_response.dart';

class MovieGenreMapper {
  static MovieGenre toEntity(MovieGenreDb genre) =>
      MovieGenre(id: genre.id, name: genre.name);
}