import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/presentation/providers/series/tv_series_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularTvSeriesProvider = FutureProvider<List<TvSeries>>((ref) {
  return ref.watch(tvSeriesRepositoryProvider).getPopularSeries();
});

final tvSeriesByIdProvider = FutureProvider.family<TvSeries, String>((
  ref,
  seriesId,
) {
  return ref.watch(tvSeriesRepositoryProvider).getSeriesById(seriesId);
});