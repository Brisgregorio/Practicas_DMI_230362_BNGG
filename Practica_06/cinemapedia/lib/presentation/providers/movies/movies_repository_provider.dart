import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';

final movieDatasourceProvider = Provider<MoviesDatasource>((ref) {
  final country = ref.watch(selectedCinemaCountryProvider);
  return MoviedbDatasource(language: country.language, region: country.code);
});

final movieRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MovieRepositoryImpl(ref.watch(movieDatasourceProvider));
});
