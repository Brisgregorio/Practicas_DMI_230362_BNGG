import 'package:cinemapedia/domain/entities/movie_genre.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final genres = ref.watch(movieGenresProvider);
    final selectedGenreId = ref.watch(selectedMovieGenreIdProvider);
    final selectedMovies = selectedGenreId == null
        ? null
        : ref.watch(moviesByGenreProvider(selectedGenreId));
    MovieGenre? selectedGenre;
    for (final genre in genres.asData?.value ?? const <MovieGenre>[]) {
      if (genre.id == selectedGenreId) selectedGenre = genre;
    }

    return Column(
      children: [
        AppBar(
          title: Text(l10n.categories),
          leading: Builder(
            builder: (context) => IconButton(
              tooltip: l10n.openMenu,
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        Expanded(
          child: genres.when(
            data: (genreList) => ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                Text(
                  l10n.selectGenre,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: genreList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final genre = genreList[index];
                    return _GenreTile(
                      key: ValueKey('genre-${genre.id}'),
                      genre: genre,
                      selected: genre.id == selectedGenreId,
                      onTap: () => ref
                          .read(selectedMovieGenreIdProvider.notifier)
                          .state = genre.id,
                    );
                  },
                ),
                if (genreList.isEmpty) ...[
                  const SizedBox(height: 20),
                  Center(child: Text(l10n.noMoviesForGenre)),
                ],
                if (selectedGenre != null && selectedMovies != null) ...[
                  const SizedBox(height: 16),
                  selectedMovies.when(
                    data: (movies) => movies.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(l10n.noMoviesForGenre),
                          )
                        : MovieHorizontalListview(
                            movies: movies,
                            title: selectedGenre!.name,
                          ),
                    loading: () => const SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    error: (error, stackTrace) => Column(
                      children: [
                        Text(l10n.genreMoviesLoadFailed),
                        TextButton(
                          onPressed: () => ref.invalidate(
                            moviesByGenreProvider(selectedGenreId!),
                          ),
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.genresLoadFailed),
                  TextButton(
                    onPressed: () => ref.invalidate(movieGenresProvider),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GenreTile extends StatelessWidget {
  final MovieGenre genre;
  final bool selected;
  final VoidCallback onTap;

  const _GenreTile({
    super.key,
    required this.genre,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? colorScheme.primary.withValues(alpha: 0.22)
          : colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(_genreIcon(genre.id), color: colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  genre.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _genreIcon(int id) => switch (id) {
    28 => Icons.local_fire_department_outlined,
    12 => Icons.explore_outlined,
    16 => Icons.animation_outlined,
    35 => Icons.sentiment_very_satisfied_outlined,
    80 => Icons.gavel_outlined,
    99 => Icons.movie_filter_outlined,
    18 => Icons.theater_comedy_outlined,
    10751 => Icons.family_restroom_outlined,
    14 => Icons.auto_awesome_outlined,
    36 => Icons.history_edu_outlined,
    27 => Icons.nights_stay_outlined,
    10402 => Icons.music_note_outlined,
    9648 => Icons.search_outlined,
    10749 => Icons.favorite_border,
    878 => Icons.rocket_launch_outlined,
    10770 => Icons.tv_outlined,
    53 => Icons.visibility_outlined,
    10752 => Icons.shield_outlined,
    37 => Icons.landscape_outlined,
    _ => Icons.local_movies_outlined,
  };
}