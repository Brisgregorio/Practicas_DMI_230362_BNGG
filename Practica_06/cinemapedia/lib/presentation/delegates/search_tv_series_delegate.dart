import 'dart:async';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

typedef SearchTvSeriesCallback = Future<List<TvSeries>> Function(String query);

class SearchTvSeriesDelegate extends SearchDelegate<TvSeries?> {
  final AppLocalizations localizations;
  final SearchTvSeriesCallback searchSeries;

  final StreamController<_TvSeriesSearchState> _states =
      StreamController.broadcast();
  _TvSeriesSearchState _state = const _TvSeriesSearchState();
  Timer? _debounceTimer;
  String? _scheduledQuery;
  int _requestId = 0;
  bool _isDisposed = false;

  SearchTvSeriesDelegate({
    required this.localizations,
    required this.searchSeries,
  }) : super(searchFieldLabel: localizations.searchTvSeries);

  void _searchFor(String value, {bool retry = false}) {
    if (_isDisposed) return;
    final normalizedQuery = value.trim();
    if (normalizedQuery.isEmpty) {
      _debounceTimer?.cancel();
      _requestId++;
      _scheduledQuery = '';
      _emit(const _TvSeriesSearchState());
      return;
    }

    if (!retry && normalizedQuery == _scheduledQuery) return;
    _scheduledQuery = normalizedQuery;
    final requestId = ++_requestId;
    _debounceTimer?.cancel();
    _emit(const _TvSeriesSearchState(isLoading: true));

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final results = await searchSeries(normalizedQuery);
        if (_isDisposed || requestId != _requestId) return;
        _emit(_TvSeriesSearchState(results: results));
      } catch (error) {
        if (_isDisposed || requestId != _requestId) return;
        debugPrint('TV series search failed: ${error.runtimeType}');
        _emit(_TvSeriesSearchState(error: error));
      }
    });
  }

  void _emit(_TvSeriesSearchState state) {
    _state = state;
    if (!_isDisposed && !_states.isClosed) _states.add(state);
  }

  void _disposeSearch() {
    if (_isDisposed) return;
    _isDisposed = true;
    _debounceTimer?.cancel();
    _states.close();
  }

  @override
  void close(BuildContext context, TvSeries? result) {
    _disposeSearch();
    super.close(context, result);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isEmpty) return const [];
    return [
      IconButton(
        tooltip: localizations.clearTvSeriesSearch,
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    onPressed: () => close(context, null),
    icon: const Icon(Icons.arrow_back_ios_new_rounded),
  );

  @override
  Widget buildResults(BuildContext context) {
    _searchFor(query);
    return _buildSearchBody();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _searchFor(query);
    return _buildSearchBody();
  }

  Widget _buildSearchBody() {
    return StreamBuilder<_TvSeriesSearchState>(
      stream: _states.stream,
      initialData: _state,
      builder: (context, snapshot) {
        final state = snapshot.data ?? _state;
        if (query.trim().isEmpty) {
          return Center(child: Text(localizations.searchTvSeriesHint));
        }
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
        if (state.error != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(localizations.tvSeriesSearchFailed),
                TextButton(
                  onPressed: () => _searchFor(query, retry: true),
                  child: Text(localizations.retry),
                ),
              ],
            ),
          );
        }
        if (state.results.isEmpty) {
          return Center(child: Text(localizations.noTvSeriesResults));
        }

        return ListView.separated(
          itemCount: state.results.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final series = state.results[index];
            return _TvSeriesSearchResult(
              series: series,
              onTap: () => close(context, series),
            );
          },
        );
      },
    );
  }
}

class _TvSeriesSearchState {
  final bool isLoading;
  final List<TvSeries> results;
  final Object? error;

  const _TvSeriesSearchState({
    this.isLoading = false,
    this.results = const [],
    this.error,
  });
}

class _TvSeriesSearchResult extends StatelessWidget {
  final TvSeries series;
  final VoidCallback onTap;

  const _TvSeriesSearchResult({required this.series, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overview = series.overview.trim();

    return ListTile(
      key: ValueKey('tv-series-search-result-${series.id}'),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          series.posterPath,
          width: 64,
          height: 96,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox(
            width: 64,
            height: 96,
            child: ColoredBox(
              color: Color(0xFF25264F),
              child: Icon(Icons.live_tv_outlined, color: Colors.white70),
            ),
          ),
        ),
      ),
      title: Text(
        series.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (series.firstAirDate case final firstAirDate?)
            Text(
              MaterialLocalizations.of(context).formatFullDate(firstAirDate),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          Row(
            children: [
              Icon(Icons.star_rounded, color: Colors.amber.shade700, size: 18),
              const SizedBox(width: 4),
              Text(HumanFormats.number(series.voteAverage, 1)),
            ],
          ),
          if (overview.isNotEmpty)
            Text(overview, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
      isThreeLine: overview.isNotEmpty,
    );
  }
}
