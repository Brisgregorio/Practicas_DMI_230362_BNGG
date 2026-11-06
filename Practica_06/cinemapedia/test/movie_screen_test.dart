import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('movie screen renders details after selecting a movie', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          movieRepositoryProvider.overrideWith(
            (ref) => _TestMoviesRepository(),
          ),
          actorsRepositoryProvider.overrideWith(
            (ref) => ActorRepositoryImpl(_TestActorsDatasource()),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('es'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const MovieScreen(movieId: '42'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Película de prueba'), findsWidgets);
    expect(find.text('Sinopsis de prueba'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}

class _TestMoviesRepository implements MoviesRepository {
  Movie _movie(String id) => Movie(
    adult: false,
    backdropPath: '',
    genreIds: const [],
    id: int.parse(id),
    originalLanguage: 'es',
    originalTitle: 'Película original',
    overview: 'Sinopsis de prueba',
    popularity: 0,
    posterPath: '',
    releaseDate: DateTime(2024),
    title: 'Película de prueba',
    video: false,
    voteAverage: 8,
    voteCount: 10,
  );

  @override
  Future<Movie> getMovieById(String id) async => _movie(id);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async => [];

  @override
  Future<List<Movie>> getPopular({int page = 1}) async => [];

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async => [];

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async => [];

  @override
  Future<List<Movie>> searchMovies(String query) async => [];
}

class _TestActorsDatasource implements ActorsDatasource {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async => [];
}
