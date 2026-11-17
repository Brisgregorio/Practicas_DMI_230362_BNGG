import 'package:cinemapedia/domain/datasources/tv_series_datasource.dart';
import 'package:cinemapedia/domain/repositories/tv_series_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/tv_series_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/tv_series_repository_impl.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tvSeriesDatasourceProvider = Provider<TvSeriesDatasource>((ref) {
  final country = ref.watch(selectedCinemaCountryProvider);
  return TvSeriesMovieDbDatasource(
    language: country.language,
    region: country.code,
  );
});

final tvSeriesRepositoryProvider = Provider<TvSeriesRepository>((ref) {
  return TvSeriesRepositoryImpl(ref.watch(tvSeriesDatasourceProvider));
});
