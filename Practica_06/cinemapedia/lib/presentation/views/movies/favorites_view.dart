import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final favorites = ref.watch(favoriteMoviesProvider);
    final favoriteSeries = ref.watch(favoriteTvSeriesProvider);
    final favoriteMovies = favorites.asData?.value;
    final series = favoriteSeries.asData?.value;

    return Column(
      children: [
        AppBar(
          title: Text(l10n.favorites),
          leading: Builder(
            builder: (context) => IconButton(
              tooltip: l10n.openMenu,
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        Expanded(
          child: favorites.isLoading || favoriteSeries.isLoading
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : favorites.hasError || favoriteSeries.hasError
              ? Center(child: Text(l10n.favoritesLoadFailed))
              : (favoriteMovies?.isEmpty ?? true) && (series?.isEmpty ?? true)
              ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite_border, size: 40),
                        const SizedBox(height: 10),
                        Text(l10n.noFavorites),
                      ],
                    ),
                  )
              : ListView(
                  children: [
                    if (favoriteMovies!.isNotEmpty)
                      MovieHorizontalListview(
                        movies: favoriteMovies,
                        title: l10n.favorites,
                      ),
                    if (series!.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                        child: Text(
                          l10n.series,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TvSeriesGrid(
                        series: series,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}