import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_providers.dart';
import 'package:cinemapedia/presentation/widgets/series/favorite_tv_series_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeriesDetailScreen extends ConsumerWidget {
  static const name = 'series-detail';

  final String seriesId;

  const SeriesDetailScreen({super.key, required this.seriesId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final series = ref.watch(tvSeriesByIdProvider(seriesId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.series)),
      body: series.when(
        data: (item) => _SeriesDetails(series: item),
        loading: () => const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.seriesDetailsLoadFailed),
              TextButton(
                onPressed: () => ref.invalidate(tvSeriesByIdProvider(seriesId)),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeriesDetails extends StatelessWidget {
  final TvSeries series;

  const _SeriesDetails({required this.series});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        Image.network(
          series.backdropPath,
          height: 230,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox(
            height: 230,
            child: Center(child: Icon(Icons.live_tv_outlined, size: 48)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 8, 4),
          child: Row(
            children: [
              Expanded(
                child: Text(series.name, style: theme.textTheme.titleLarge),
              ),
              FavoriteTvSeriesButton(series: series),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(series.overview),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 6),
              Text(series.voteAverage.toStringAsFixed(1)),
              const SizedBox(width: 16),
              Text(series.firstAirDate.year.toString()),
            ],
          ),
        ),
      ],
    );
  }
}