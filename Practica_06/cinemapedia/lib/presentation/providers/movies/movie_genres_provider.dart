import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_genre.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenresProvider = FutureProvider<List<MovieGenre>>((ref) {
  return ref.watch(movieRepositoryProvider).getMovieGenres();
});

final selectedMovieGenreIdProvider = StateProvider<int?>((ref) => null);

final moviesByGenreProvider = FutureProvider.family<List<Movie>, int>((
  ref,
  genreId,
) {
  return ref
      .watch(movieRepositoryProvider)
      .getMoviesByGenre(genreId: genreId);
});