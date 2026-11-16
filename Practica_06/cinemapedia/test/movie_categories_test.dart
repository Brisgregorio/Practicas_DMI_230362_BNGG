import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_genre.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/presentation/views/movies/categories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selecting a genre requests its movies', (tester) async {
    final repository = _CategoriesMoviesRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          movieRepositoryProvider.overrideWith((ref) => repository),
        ],
        child: MaterialApp(
          locale: const Locale('es'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const Scaffold(body: CategoriesView()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Acción'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('genre-28')));
    await tester.pumpAndSettle();

    expect(repository.requestedGenreIds, [28]);
    expect(find.text('No hay películas disponibles en este género.'), findsOneWidget);
  });
}

class _CategoriesMoviesRepository implements MoviesRepository {
  final requestedGenreIds = <int>[];

  @override
  Future<List<MovieGenre>> getMovieGenres() async => const [
    MovieGenre(id: 28, name: 'Acción'),
  ];

  @override
  Future<List<Movie>> getMoviesByGenre({required int genreId, int page = 1}) async {
    requestedGenreIds.add(genreId);
    return [];
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async => [];

  @override
  Future<List<Movie>> getPopular({int page = 1}) async => [];

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async => [];

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async => [];

  @override
  Future<Movie> getMovieById(String id) async =>
      throw UnsupportedError('Movie details are not part of this test.');

  @override
  Future<List<Movie>> searchMovies(String query) async => [];
}
