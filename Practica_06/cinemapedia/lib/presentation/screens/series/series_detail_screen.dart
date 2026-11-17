import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_providers.dart';
import 'package:cinemapedia/presentation/widgets/series/favorite_tv_series_button.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
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
    return series.when(
      data: (item) => Scaffold(body: _SeriesDetails(series: item)),
      loading: () => Scaffold(
        appBar: AppBar(title: Text(l10n.series)),
        body: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(title: Text(l10n.series)),
        body: Center(
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final firstAirDate = series.firstAirDate;
    final lastAirDate = series.lastAirDate;
    final status = series.status?.trim();
    final overview = series.overview.trim();

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _SeriesSliverAppBar(series: series),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SeriesPoster(
                      path: series.posterPath,
                      width: size.width * 0.32,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(series.name, style: theme.textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(
                            overview.isEmpty
                                ? l10n.tvSeriesOverviewUnavailable
                                : overview,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                series.voteAverage.toStringAsFixed(1),
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                          Text(l10n.tvSeriesVotes(series.voteCount)),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FavoriteTvSeriesButton(series: series),
                ),
                if (series.genres.isNotEmpty) ...[
                  _SectionTitle(title: l10n.tvSeriesGenres),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final genre in series.genres)
                        Chip(label: Text(genre.name)),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                if (firstAirDate != null)
                  _SeriesFact(
                    label: l10n.tvSeriesFirstAirDate,
                    value: MaterialLocalizations.of(context)
                        .formatFullDate(firstAirDate),
                  ),
                if (lastAirDate != null)
                  _SeriesFact(
                    label: l10n.tvSeriesLastAirDate,
                    value: MaterialLocalizations.of(context)
                        .formatFullDate(lastAirDate),
                  ),
                if (status != null && status.isNotEmpty)
                  _SeriesFact(label: l10n.tvSeriesStatus, value: status),
                if (series.numberOfSeasons != null)
                  _SeriesFact(
                    label: l10n.tvSeriesSeasons,
                    value: series.numberOfSeasons.toString(),
                  ),
                if (series.numberOfEpisodes != null)
                  _SeriesFact(
                    label: l10n.tvSeriesEpisodes,
                    value: series.numberOfEpisodes.toString(),
                  ),
                _SeriesNamesSection(
                  title: l10n.tvSeriesCreators,
                  names: series.createdBy
                      .map((creator) => creator.name)
                      .toList(),
                ),
                _SeriesNamesSection(
                  title: l10n.tvSeriesProductionCompanies,
                  names: series.productionCompanies
                      .map((company) => company.name)
                      .toList(),
                ),
                _SeriesNamesSection(
                  title: l10n.tvSeriesNetworks,
                  names: series.networks
                      .map((network) => network.name)
                      .toList(),
                ),
                _SeriesCastSection(seriesId: series.id.toString()),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SeriesCastSection extends ConsumerWidget {
  final String seriesId;

  const _SeriesCastSection({required this.seriesId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cast = ref.watch(tvSeriesCastProvider(seriesId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: l10n.castTitle),
        cast.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          error: (error, stackTrace) => Row(
            children: [
              Expanded(child: Text(l10n.castLoadFailed)),
              TextButton(
                onPressed: () => ref.invalidate(tvSeriesCastProvider(seriesId)),
                child: Text(l10n.retry),
              ),
            ],
          ),
          data: (actors) => actors.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(l10n.castEmpty),
                )
              : SizedBox(
                  height: 320,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: actors.length,
                    itemBuilder: (context, index) =>
                        _SeriesCastCard(actor: actors[index]),
                  ),
                ),
        ),
      ],
    );
  }
}

class _SeriesCastCard extends StatelessWidget {
  final Actor actor;

  const _SeriesCastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: actor.profilePath.isEmpty
                  ? _photoPlaceholder()
                  : Image.network(
                      actor.profilePath,
                      width: 123,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _photoPlaceholder(),
                    ),
            ),
            const SizedBox(height: 6),
            Text(actor.name, maxLines: 2, overflow: TextOverflow.ellipsis),
            Text(
              actor.character ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (actor.order != null)
              Text(
                '#${actor.order}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }

  Widget _photoPlaceholder() => const ColoredBox(
    color: Color(0xFF25264F),
    child: SizedBox(
      width: 123,
      height: 180,
      child: Icon(Icons.person_outline, color: Colors.white70, size: 48),
    ),
  );
}

class _SeriesPoster extends StatelessWidget {
  final String path;
  final double width;

  const _SeriesPoster({required this.path, required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: path.isEmpty
          ? _placeholder(width)
          : Image.network(
              path,
              width: width,
              height: width * 1.5,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _placeholder(width),
            ),
    );
  }

  Widget _placeholder(double width) => ColoredBox(
    color: const Color(0xFF25264F),
    child: SizedBox(
      width: width,
      height: width * 1.5,
      child: const Icon(Icons.live_tv_outlined, color: Colors.white70),
    ),
  );
}

class _SeriesSliverAppBar extends StatelessWidget {
  final TvSeries series;

  const _SeriesSliverAppBar({required this.series});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.55,
      foregroundColor: Colors.white,
      title: const CinemapediaBrand(
        compact: true,
        foregroundColor: Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          series.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (series.backdropPath.isEmpty)
              const _BackdropPlaceholder()
            else
              Image.network(
                series.backdropPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const _BackdropPlaceholder(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const _BackdropPlaceholder(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return child;
                },
              ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.55, 1],
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  stops: [0, 0.3],
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackdropPlaceholder extends StatelessWidget {
  final Widget? child;

  const _BackdropPlaceholder({this.child});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: const Color(0xFF25264F),
    child: Center(
      child:
          child ??
          const Icon(Icons.live_tv_outlined, size: 64, color: Colors.white54),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );
}

class _SeriesFact extends StatelessWidget {
  final String label;
  final String value;

  const _SeriesFact({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(label, style: Theme.of(context).textTheme.titleSmall),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

class _SeriesNamesSection extends StatelessWidget {
  final String title;
  final List<String> names;

  const _SeriesNamesSection({required this.title, required this.names});

  @override
  Widget build(BuildContext context) {
    if (names.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        Wrap(
          spacing: 8,
          children: [for (final name in names) Chip(label: Text(name))],
        ),
      ],
    );
  }
}
