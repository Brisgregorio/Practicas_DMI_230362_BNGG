import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/datasources/tmdb_dio.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  ActorMovieDbDatasource({required String language, required String region})
    : dio = createTmdbDio(language: language, region: region);

  final Dio dio;

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return runTmdbRequest(() async {
      final response = await dio.get('/movie/$movieId/credits');
      final castResponse = CreditsResponse.fromJson(response.data);
      return castResponse.cast
          .map((cast) => ActorMapper.castToEntity(cast))
          .toList();
    });
  }
}
