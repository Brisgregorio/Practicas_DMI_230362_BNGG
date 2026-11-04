import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/foundation.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final movieRepository = ref.watch(movieRepositoryProvider);
      return MovieMapNotifier(getMovie: movieRepository.getMovieById);
    });

/*
  {
    '505642': Movie(),
    '505643': Movie(),
    '505645': Movie(),
    '501231': Movie(),
  }
*/

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  final Set<String> failedMovieIds = {};
  final Set<String> loadingMovieIds = {};

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null || !loadingMovieIds.add(movieId)) return;
    failedMovieIds.remove(movieId);
    try {
      final movie = await getMovie(movieId);
      if (!mounted) return;
      state = {...state, movieId: movie};
    } catch (error) {
      if (!mounted) return;
      debugPrint('Movie details request failed: ${error.runtimeType}');
      failedMovieIds.add(movieId);
      state = Map<String, Movie>.from(state);
    } finally {
      loadingMovieIds.remove(movieId);
    }
  }

  bool hasError(String movieId) => failedMovieIds.contains(movieId);
}
