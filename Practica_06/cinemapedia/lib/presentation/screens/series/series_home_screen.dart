import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_providers.dart';
import 'package:cinemapedia/presentation/widgets/series/tv_series_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeriesHomeScreen extends ConsumerWidget {
  static const name = 'series-home';

  const SeriesHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final series = ref.watch(popularTvSeriesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.series)),
      body: series.when(
        data: (items) => items.isEmpty
            ? Center(child: Text(l10n.noPopularSeries))
            : TvSeriesGrid(series: items),
        loading: () => const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.seriesLoadFailed),
              TextButton(
                onPressed: () => ref.invalidate(popularTvSeriesProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}