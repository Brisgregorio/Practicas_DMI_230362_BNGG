import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:cinemapedia/presentation/providers/series/favorite_tv_series_provider.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('favorite series persist and can be removed by id', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    final notifier = container.read(favoriteTvSeriesProvider.notifier);
    await notifier.initialized;
    await notifier.toggle(_series());

    expect(container.read(favoriteTvSeriesProvider).requireValue.single.id, 8);
    expect(
      preferences.getStringList(favoriteTvSeriesPreferenceKey),
      hasLength(1),
    );

    final reloadedContainer = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(reloadedContainer.dispose);
    final reloadedNotifier = reloadedContainer.read(
      favoriteTvSeriesProvider.notifier,
    );
    await reloadedNotifier.initialized;
    expect(
      reloadedContainer.read(favoriteTvSeriesProvider).requireValue.single.name,
      'Serie favorita',
    );

    await reloadedNotifier.toggle(_series());
    expect(reloadedContainer.read(favoriteTvSeriesProvider).requireValue, isEmpty);
  });
}

TvSeries _series() => TvSeries(
  adult: false,
  backdropPath: 'backdrop.jpg',
  firstAirDate: DateTime(2020),
  genreIds: const [10759],
  id: 8,
  originalLanguage: 'es',
  originalName: 'Serie favorita',
  overview: 'Sinopsis',
  popularity: 12,
  posterPath: 'poster.jpg',
  name: 'Serie favorita',
  voteAverage: 8.1,
  voteCount: 30,
);
