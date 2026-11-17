import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/delegates/search_tv_series_delegate.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_providers.dart';
import 'package:cinemapedia/presentation/screens/series/series_detail_screen.dart';
import 'package:cinemapedia/presentation/widgets/series/tv_series_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SeriesHomeScreen extends ConsumerWidget {
  static const name = 'series-home';

  const SeriesHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final series = ref.watch(popularTvSeriesProvider);
    final genres = ref.watch(tvSeriesGenresProvider);
    final selectedGenreId = ref.watch(selectedTvSeriesGenreIdProvider);
    final showDrawerButton = MediaQuery.sizeOf(context).width < 760;
    final genreSeries = selectedGenreId == null
        ? null
        : ref.watch(tvSeriesByGenreProvider(selectedGenreId));
    return SafeArea(
      top: true,
      child: Column(
        children: [
          AppBar(
            leading: showDrawerButton
                ? Builder(
                    builder: (context) => IconButton(
                      tooltip: l10n.openMenu,
                      icon: const Icon(Icons.menu_rounded),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  )
                : null,
            title: Text(l10n.series),
            actions: [
              IconButton(
                key: const ValueKey('search-tv-series'),
                tooltip: l10n.searchTvSeries,
                icon: const Icon(Icons.search),
                onPressed: () async {
                  final selectedSeries = await showSearch<TvSeries?>(
                    context: context,
                    delegate: SearchTvSeriesDelegate(
                      localizations: l10n,
                      searchSeries: (query) {
                        final searchProvider = tvSeriesSearchProvider(query);
                        ref.invalidate(searchProvider);
                        return ref.read(searchProvider.future);
                      },
                    ),
                  );
                  if (selectedSeries == null || !context.mounted) return;
                  context.pushNamed(
                    SeriesDetailScreen.name,
                    pathParameters: {'id': selectedSeries.id.toString()},
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.tvSeriesGenres,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
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
                      key: const ValueKey('tv-genre-all'),
                      label: Text(l10n.all),
                      selected: selectedGenreId == null,
                      onSelected: (_) =>
                          ref
                                  .read(
                                    selectedTvSeriesGenreIdProvider.notifier,
                                  )
                                  .state =
                              null,
                    ),
                  ),
                  for (final genre in items)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        key: ValueKey('tv-genre-${genre.id}'),
                        label: Text(genre.name),
                        selected: genre.id == selectedGenreId,
                        onSelected: (_) =>
                            ref
                                .read(selectedTvSeriesGenreIdProvider.notifier)
                                .state = genre
                                .id,
                      ),
                    ),
                ],
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (error, stackTrace) => Center(
                child: TextButton(
                  onPressed: () => ref.invalidate(tvSeriesGenresProvider),
                  child: Text(l10n.tvSeriesGenresLoadFailed),
                ),
              ),
            ),
          ),
          Expanded(
            child: selectedGenreId == null
                ? series.when(
                    data: (items) => items.isEmpty
                        ? Center(child: Text(l10n.noPopularSeries))
                        : TvSeriesGrid(series: items, childAspectRatio: 0.9),
                    loading: () => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (error, stackTrace) => _SeriesLoadError(
                      message: l10n.seriesLoadFailed,
                      onRetry: () => ref.invalidate(popularTvSeriesProvider),
                      retryLabel: l10n.retry,
                    ),
                  )
                : genreSeries!.when(
                    data: (items) => items.isEmpty
                        ? Center(child: Text(l10n.noTvSeriesForGenre))
                        : TvSeriesGrid(series: items, childAspectRatio: 0.9),
                    loading: () => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (error, stackTrace) => _SeriesLoadError(
                      message: l10n.tvSeriesGenreResultsLoadFailed,
                      onRetry: () => ref.invalidate(
                        tvSeriesByGenreProvider(selectedGenreId),
                      ),
                      retryLabel: l10n.retry,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SeriesLoadError extends StatelessWidget {
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  const _SeriesLoadError({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
        TextButton(onPressed: onRetry, child: Text(retryLabel)),
      ],
    ),
  );
}
