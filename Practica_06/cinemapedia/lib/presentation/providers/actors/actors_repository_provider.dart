import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';


// Este repositorio es inmutable
final actorsRepositoryProvider = Provider((ref) {
  final country = ref.watch(selectedCinemaCountryProvider);
  return ActorRepositoryImpl(
    ActorMovieDbDatasource(
      language: country.language,
      region: country.code,
    ),
  );
});
