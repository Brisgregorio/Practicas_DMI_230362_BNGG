import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/series/favorite_tv_series_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteTvSeriesButton extends ConsumerWidget {
  final TvSeries series;

  const FavoriteTvSeriesButton({super.key, required this.series});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final favorites = ref.watch(favoriteTvSeriesProvider);
    return favorites.when(
      data: (items) {
        final isFavorite = items.any((item) => item.id == series.id);
        return IconButton(
          key: ValueKey('favorite-series-${series.id}'),
          tooltip: isFavorite ? l10n.removeFromFavorites : l10n.addToFavorites,
          onPressed: () =>
              ref.read(favoriteTvSeriesProvider.notifier).toggle(series),
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.pinkAccent : null,
          ),
        );
      },
      loading: () =>
          const IconButton(onPressed: null, icon: Icon(Icons.favorite_border)),
      error: (error, stackTrace) =>
          const IconButton(onPressed: null, icon: Icon(Icons.favorite_border)),
    );
  }
}
