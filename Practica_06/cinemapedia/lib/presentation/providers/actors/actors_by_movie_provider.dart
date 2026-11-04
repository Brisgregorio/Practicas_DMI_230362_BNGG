import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final actorsRepository = ref.watch(actorsRepositoryProvider);

      return ActorsByMovieNotifier(
        getActors: actorsRepository.getActorsByMovie,
      );
    });

/*
  {
    '505642': <Actor>[],
    '505643': <Actor>[],
    '505645': <Actor>[],
    '501231': <Actor>[],
  }
*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;
  final Set<String> failedMovieIds = {};
  final Set<String> loadingMovieIds = {};

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null || !loadingMovieIds.add(movieId)) return;

    failedMovieIds.remove(movieId);
    try {
      final List<Actor> actors = await getActors(movieId);
      if (!mounted) return;
      state = {...state, movieId: actors};
    } catch (error) {
      if (!mounted) return;
      debugPrint('Movie cast request failed: ${error.runtimeType}');
      failedMovieIds.add(movieId);
      state = Map<String, List<Actor>>.from(state);
    } finally {
      loadingMovieIds.remove(movieId);
    }
  }

  bool hasError(String movieId) => failedMovieIds.contains(movieId);
}
