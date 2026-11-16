import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlaying = ref.watch(nowPlayingMoviesProvider);
  final popular = ref.watch(popularMoviesProvider);
  final topRated = ref.watch(topRatedMoviesProvider);
  final upcoming = ref.watch(upcomingMoviesProvider);

  final nowPlayingLoaded = ref.read(nowPlayingMoviesProvider.notifier).hasLoaded;
  final popularLoaded = ref.read(popularMoviesProvider.notifier).hasLoaded;
  final topRatedLoaded = ref.read(topRatedMoviesProvider.notifier).hasLoaded;
  final upcomingLoaded = ref.read(upcomingMoviesProvider.notifier).hasLoaded;

  return (nowPlaying.isEmpty && !nowPlayingLoaded) ||
      (popular.isEmpty && !popularLoaded) ||
      (topRated.isEmpty && !topRatedLoaded) ||
      (upcoming.isEmpty && !upcomingLoaded);
});
