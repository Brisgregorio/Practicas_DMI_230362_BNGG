import 'dart:convert';

import 'package:cinemapedia/presentation/providers/movies/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('favorites persist, toggle by id, and ignore stored duplicates', () async {
    final storedMovie = jsonEncode(_movieJson());
    SharedPreferences.setMockInitialValues({
      favoriteMoviesPreferenceKey: [storedMovie, storedMovie],
    });
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    final notifier = container.read(favoriteMoviesProvider.notifier);
    await notifier.initialized;
    expect(container.read(favoriteMoviesProvider).requireValue, hasLength(1));

    final movie = container.read(favoriteMoviesProvider).requireValue.single;
    await notifier.toggle(movie);
    expect(container.read(favoriteMoviesProvider).requireValue, isEmpty);
    expect(preferences.getStringList(favoriteMoviesPreferenceKey), isEmpty);

    await notifier.toggle(movie);
    expect(preferences.getStringList(favoriteMoviesPreferenceKey), hasLength(1));

    final reloadedContainer = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(reloadedContainer.dispose);
    final reloadedNotifier = reloadedContainer.read(
      favoriteMoviesProvider.notifier,
    );
    await reloadedNotifier.initialized;
    expect(
      reloadedContainer.read(favoriteMoviesProvider).requireValue.single.title,
      'Película favorita',
    );
  });
}

Map<String, dynamic> _movieJson() => {
  'adult': false,
  'backdropPath': 'backdrop.jpg',
  'genreIds': ['28'],
  'id': 101,
  'originalLanguage': 'es',
  'originalTitle': 'Película favorita',
  'overview': 'Sinopsis',
  'popularity': 12.5,
  'posterPath': 'poster.jpg',
  'releaseDate': DateTime(2024).toIso8601String(),
  'title': 'Película favorita',
  'video': false,
  'voteAverage': 8.2,
  'voteCount': 400,
};
