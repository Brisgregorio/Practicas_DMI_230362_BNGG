import 'dart:convert';

import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const favoriteTvSeriesPreferenceKey = 'favorite_tv_series_v1';

final favoriteTvSeriesProvider = StateNotifierProvider<
  FavoriteTvSeriesNotifier,
  AsyncValue<List<TvSeries>>
>((ref) {
  return FavoriteTvSeriesNotifier(ref.watch(sharedPreferencesProvider));
});

class FavoriteTvSeriesNotifier extends StateNotifier<AsyncValue<List<TvSeries>>> {
  final SharedPreferences _preferences;
  late final Future<void> initialized;

  FavoriteTvSeriesNotifier(this._preferences) : super(const AsyncLoading()) {
    initialized = _load();
  }

  Future<void> _load() async {
    final storedSeries =
        _preferences.getStringList(favoriteTvSeriesPreferenceKey) ??
        const <String>[];
    final series = <TvSeries>[];
    for (final stored in storedSeries) {
      try {
        final item = _decodeSeries(stored);
        if (series.every((saved) => saved.id != item.id)) series.add(item);
      } on Object {
        continue;
      }
    }
    state = AsyncData(series);
  }

  Future<void> toggle(TvSeries series) async {
    final favorites = state.asData?.value;
    if (favorites == null) return;

    final isFavorite = favorites.any((favorite) => favorite.id == series.id);
    final updatedFavorites = isFavorite
        ? favorites.where((favorite) => favorite.id != series.id).toList()
        : [series, ...favorites];
    state = AsyncData(updatedFavorites);

    try {
      final saved = await _preferences.setStringList(
        favoriteTvSeriesPreferenceKey,
        updatedFavorites.map(_encodeSeries).toList(),
      );
      if (!saved) throw StateError('Favorite series could not be saved.');
    } on Object catch (error, stackTrace) {
      if (mounted) state = AsyncError(error, stackTrace);
    }
  }
}

String _encodeSeries(TvSeries series) => jsonEncode({
  'adult': series.adult,
  'backdropPath': series.backdropPath,
  'firstAirDate': series.firstAirDate.toIso8601String(),
  'genreIds': series.genreIds,
  'id': series.id,
  'originalLanguage': series.originalLanguage,
  'originalName': series.originalName,
  'overview': series.overview,
  'popularity': series.popularity,
  'posterPath': series.posterPath,
  'name': series.name,
  'voteAverage': series.voteAverage,
  'voteCount': series.voteCount,
});

TvSeries _decodeSeries(String encoded) {
  final json = jsonDecode(encoded) as Map<String, dynamic>;
  return TvSeries(
    adult: json['adult'] as bool? ?? false,
    backdropPath: json['backdropPath'] as String? ?? '',
    firstAirDate:
        DateTime.tryParse(json['firstAirDate'] as String? ?? '') ??
        DateTime(1970),
    genreIds: ((json['genreIds'] as List<dynamic>?) ?? const [])
        .map((id) => (id as num).toInt())
        .toList(),
    id: json['id'] as int,
    originalLanguage: json['originalLanguage'] as String? ?? '',
    originalName: json['originalName'] as String? ?? '',
    overview: json['overview'] as String? ?? '',
    popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
    posterPath: json['posterPath'] as String? ?? '',
    name: json['name'] as String? ?? '',
    voteAverage: (json['voteAverage'] as num?)?.toDouble() ?? 0,
    voteCount: json['voteCount'] as int? ?? 0,
  );
}