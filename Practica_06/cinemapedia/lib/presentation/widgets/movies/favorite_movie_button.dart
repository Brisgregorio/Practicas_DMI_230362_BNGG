import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/movies/favorite_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMovieButton extends ConsumerWidget {
  final Movie movie;

  const FavoriteMovieButton({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final favorites = ref.watch(favoriteMoviesProvider);

    return favorites.when(
      data: (movies) {
        final isFavorite = movies.any((favorite) => favorite.id == movie.id);
        return IconButton(
          key: ValueKey('favorite-movie-${movie.id}'),
          tooltip: isFavorite ? l10n.removeFromFavorites : l10n.addToFavorites,
          onPressed: () =>
              ref.read(favoriteMoviesProvider.notifier).toggle(movie),
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.pinkAccent : null,
          ),
        );
      },
      loading: () => const IconButton(
        onPressed: null,
        icon: Icon(Icons.favorite_border),
      ),
      error: (error, stackTrace) => const IconButton(
        onPressed: null,
        icon: Icon(Icons.favorite_border),
      ),
    );
  }
}