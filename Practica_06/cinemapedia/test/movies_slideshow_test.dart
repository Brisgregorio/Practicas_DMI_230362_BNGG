import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('carousel arrows advance one movie per tap', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: MoviesSlideshow(
              movies: List.generate(3, (index) => _movie(index + 1)),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Desliza para explorar · 1/3'), findsOneWidget);
    expect(find.byTooltip('Película anterior'), findsOneWidget);
    expect(find.byTooltip('Siguiente película'), findsOneWidget);

    await tester.tap(find.byTooltip('Siguiente película'));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();
    expect(find.text('Desliza para explorar · 2/3'), findsOneWidget);

    await tester.tap(find.byTooltip('Siguiente película'));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();
    expect(find.text('Desliza para explorar · 3/3'), findsOneWidget);
  });

  testWidgets('carousel cards show local and original titles and rating', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: MoviesSlideshow(movies: [_movie(1)])),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Título en idioma seleccionado'), findsOneWidget);
    expect(find.text('Título original (ES)'), findsOneWidget);
    expect(find.text('Título local 1'), findsOneWidget);
    expect(find.text('Título original 1'), findsOneWidget);
    expect(find.text('7.0'), findsOneWidget);
    expect(find.textContaining('MX · B*'), findsOneWidget);
  });

  testWidgets('double-tapping either arrow jumps to the last movie', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: MoviesSlideshow(
              movies: List.generate(3, (index) => _movie(index + 1)),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await _doubleTap(tester, 'Siguiente película');
    expect(find.text('Desliza para explorar · 3/3'), findsOneWidget);

    await tester.tap(find.byTooltip('Película anterior'));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();
    expect(find.text('Desliza para explorar · 2/3'), findsOneWidget);

    await _doubleTap(tester, 'Película anterior');
    expect(find.text('Desliza para explorar · 3/3'), findsOneWidget);

    await _doubleTap(tester, 'Película anterior');
    expect(find.text('Desliza para explorar · 1/3'), findsOneWidget);

    await _doubleTap(tester, 'Siguiente película');
    expect(find.text('Desliza para explorar · 3/3'), findsOneWidget);

    await _doubleTap(tester, 'Siguiente película');
    expect(find.text('Desliza para explorar · 1/3'), findsOneWidget);
  });

  testWidgets('shows a retry action when movie loading fails', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: MoviesSlideshow(
              movies: const [],
              hasError: true,
              onRetry: () => retried = true,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('No se pudieron cargar las películas.'), findsOneWidget);
    await tester.tap(find.text('Reintentar'));
    expect(retried, isTrue);
  });
}

Movie _movie(int id) => Movie(
  adult: false,
  backdropPath: 'https://image.tmdb.org/t/p/w500/test.jpg',
  genreIds: const [],
  id: id,
  originalLanguage: 'es',
  originalTitle: 'Título original $id',
  overview: 'Descripción',
  popularity: 1,
  posterPath: 'https://image.tmdb.org/t/p/w500/test.jpg',
  releaseDate: DateTime(2020),
  title: 'Título local $id',
  video: false,
  voteAverage: 7,
  voteCount: 1,
);

Future<void> _doubleTap(WidgetTester tester, String tooltip) async {
  await tester.pump(const Duration(milliseconds: 350));
  await tester.tap(find.byTooltip(tooltip));
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(find.byTooltip(tooltip));
  await tester.pumpAndSettle();
}
