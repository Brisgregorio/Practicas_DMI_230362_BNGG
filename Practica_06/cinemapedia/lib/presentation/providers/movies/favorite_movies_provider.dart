import 'dart:convert';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const favoriteMoviesPreferenceKey = 'favorite_movies_v1';

final favoriteMoviesProvider = StateNotifierProvider<
  FavoriteMoviesNotifier,
  AsyncValue<List<Movie>>
>((ref) {
  return FavoriteMoviesNotifier(ref.watch(sharedPreferencesProvider));
});

class FavoriteMoviesNotifier extends StateNotifier<AsyncValue<List<Movie>>> {
  final SharedPreferences _preferences;
  late final Future<void> initialized;

  FavoriteMoviesNotifier(this._preferences) : super(const AsyncLoading()) {
    initialized = _load();
  }

  Future<void> _load() async {
    final storedMovies = _preferences.getStringList(
          favoriteMoviesPreferenceKey,
        ) ??
        const <String>[];
    final movies = <Movie>[];
    for (final storedMovie in storedMovies) {
      try {
        final movie = _decodeMovie(storedMovie);
        if (movies.every((saved) => saved.id != movie.id)) movies.add(movie);
      } on Object {
        continue;
      }
    }
    state = AsyncData(movies);
  }

  Future<void> toggle(Movie movie) async {
    final favorites = state.asData?.value;
    if (favorites == null) return;

    final isFavorite = favorites.any((favorite) => favorite.id == movie.id);
    final updatedFavorites = isFavorite
        ? favorites.where((favorite) => favorite.id != movie.id).toList()
        : [movie, ...favorites];
    state = AsyncData(updatedFavorites);

    try {
      final saved = await _preferences.setStringList(
        favoriteMoviesPreferenceKey,
        updatedFavorites.map(_encodeMovie).toList(),
      );
      if (!saved) throw StateError('Favorite movies could not be saved.');
    } on Object catch (error, stackTrace) {
      if (mounted) state = AsyncError(error, stackTrace);
    }
  }
}

String _encodeMovie(Movie movie) => jsonEncode({
  'adult': movie.adult,
  'backdropPath': movie.backdropPath,
  'genreIds': movie.genreIds,
  'id': movie.id,
  'originalLanguage': movie.originalLanguage,
  'originalTitle': movie.originalTitle,
  'overview': movie.overview,
  'popularity': movie.popularity,
  'posterPath': movie.posterPath,
  'releaseDate': movie.releaseDate.toIso8601String(),
  'title': movie.title,
  'video': movie.video,
  'voteAverage': movie.voteAverage,
  'voteCount': movie.voteCount,
});

Movie _decodeMovie(String encoded) {
  final json = jsonDecode(encoded) as Map<String, dynamic>;
  return Movie(
    adult: json['adult'] as bool? ?? false,
    backdropPath: json['backdropPath'] as String? ?? '',
    genreIds: ((json['genreIds'] as List<dynamic>?) ?? const [])
        .map((genre) => genre.toString())
        .toList(),
    id: json['id'] as int,
    originalLanguage: json['originalLanguage'] as String? ?? '',
    originalTitle: json['originalTitle'] as String? ?? '',
    overview: json['overview'] as String? ?? '',
    popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
    posterPath: json['posterPath'] as String? ?? '',
    releaseDate:
        DateTime.tryParse(json['releaseDate'] as String? ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    title: json['title'] as String? ?? '',
    video: json['video'] as bool? ?? false,
    voteAverage: (json['voteAverage'] as num?)?.toDouble() ?? 0,
    voteCount: json['voteCount'] as int? ?? 0,
  );
}