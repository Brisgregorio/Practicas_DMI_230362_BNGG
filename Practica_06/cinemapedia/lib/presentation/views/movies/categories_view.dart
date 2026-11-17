import 'package:cinemapedia/domain/entities/movie_genre.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  @override
  void initState() {
    super.initState();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final showDrawerButton = MediaQuery.sizeOf(context).width < 850;
    final genres = ref.watch(movieGenresProvider);
    final selectedGenreId = ref.watch(selectedMovieGenreIdProvider);
    final selectedMovies = selectedGenreId == null
        ? null
        : ref.watch(moviesByGenreProvider(selectedGenreId));
    final allMovies = ref.watch(popularMoviesProvider);
    final allMoviesNotifier = ref.watch(popularMoviesProvider.notifier);
    final genreList = genres.asData?.value ?? const <MovieGenre>[];
    MovieGenre? selectedGenre;
    for (final genre in genreList) {
      if (genre.id == selectedGenreId) selectedGenre = genre;
    }

    return Column(
      children: [
        AppBar(
          title: Text(l10n.categories),
          leading: showDrawerButton
              ? Builder(
                  builder: (context) => IconButton(
                    tooltip: l10n.openMenu,
                    icon: const Icon(Icons.menu_rounded),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                )
              : null,
        ),
        SizedBox(
          height: 48,
          child: genres.when(
            data: (items) => ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    key: const ValueKey('genre-all'),
                    label: Text(l10n.all),
                    selected: selectedGenreId == null,
                    onSelected: (_) =>
                        ref.read(selectedMovieGenreIdProvider.notifier).state =
                            null,
                  ),
                ),
                for (final genre in items)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      key: ValueKey('genre-${genre.id}'),
                      label: Text(genre.name),
                      selected: genre.id == selectedGenreId,
                      onSelected: (_) =>
                          ref
                                  .read(selectedMovieGenreIdProvider.notifier)
                                  .state =
                              genre.id,
                    ),
                  ),
              ],
            ),
            loading: () =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            error: (error, stackTrace) => Center(
              child: TextButton(
                onPressed: () => ref.invalidate(movieGenresProvider),
                child: Text(l10n.genresLoadFailed),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: genres.when(
            loading: () =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
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
            data: (items) {
              if (selectedGenreId == null) {
                if (allMovies.isNotEmpty) {
                  return MovieHorizontalListview(
                    movies: allMovies,
                    title: l10n.popular,
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  );
                }
                if (allMoviesNotifier.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.noMoviesFailed),
                        TextButton(
                          onPressed: () => allMoviesNotifier.loadNextPage(),
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  );
                }
                if (allMoviesNotifier.hasLoaded) {
                  return Center(child: Text(l10n.noMoviesCountry));
                }
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (selectedGenre == null || selectedMovies == null) {
                return const SizedBox.shrink();
              }
              return selectedMovies.when(
                data: (movies) => movies.isEmpty
                    ? Center(child: Text(l10n.noMoviesForGenre))
                    : MovieHorizontalListview(
                        movies: movies,
                        title: selectedGenre!.name,
                      ),
                loading: () => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l10n.genreMoviesLoadFailed),
                      TextButton(
                        onPressed: () => ref.invalidate(
                          moviesByGenreProvider(selectedGenreId),
                        ),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
