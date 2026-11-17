import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/tv_series_genre.dart';
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

final tvSeriesSearchProvider = FutureProvider.autoDispose
    .family<List<TvSeries>, String>((ref, query) {
      final normalizedQuery = query.trim();
      if (normalizedQuery.isEmpty) return const [];
      return ref
          .watch(tvSeriesRepositoryProvider)
          .searchSeries(normalizedQuery);
    });

final tvSeriesCastProvider = FutureProvider.family<List<Actor>, String>((
  ref,
  seriesId,
) {
  return ref.watch(tvSeriesRepositoryProvider).getActorsBySeries(seriesId);
});

final tvSeriesGenresProvider = FutureProvider<List<TvSeriesGenre>>((ref) {
  return ref.watch(tvSeriesRepositoryProvider).getSeriesGenres();
});

final selectedTvSeriesGenreIdProvider = StateProvider<int?>((ref) => null);

final tvSeriesByGenreProvider = FutureProvider.family<List<TvSeries>, int>((
  ref,
  genreId,
) {
  return ref
      .watch(tvSeriesRepositoryProvider)
      .getSeriesByGenre(genreId: genreId);
});
