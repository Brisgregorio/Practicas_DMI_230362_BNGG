import 'package:cinemapedia/config/constants/environment.dart';
import 'package:dio/dio.dart';

Dio createTmdbDio({required String language, required String region}) {
  final apiKey = Environment.theMovieDbKey;
  if (apiKey.isEmpty) {
    throw const TmdbApiException.configuration();
  }

  return Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      queryParameters: {
        'api_key': apiKey,
        'language': language,
        'region': region,
      },
    ),
  );
}

Future<T> runTmdbRequest<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (error) {
    throw TmdbApiException.fromDio(error);
  } on FormatException {
    throw const TmdbApiException.invalidResponse();
  } on TypeError {
    throw const TmdbApiException.invalidResponse();
  }
}

enum TmdbFailure {
  configuration,
  connection,
  unauthorized,
  forbidden,
  notFound,
  timeout,
  invalidResponse,
  http,
  unexpected,
}

class TmdbApiException implements Exception {
  const TmdbApiException(this.failure, {this.statusCode});

  const TmdbApiException.configuration() : this(TmdbFailure.configuration);

  const TmdbApiException.invalidResponse() : this(TmdbFailure.invalidResponse);

  final TmdbFailure failure;
  final int? statusCode;

  factory TmdbApiException.fromDio(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode == 401) {
      return const TmdbApiException(TmdbFailure.unauthorized, statusCode: 401);
    }
    if (statusCode == 403) {
      return const TmdbApiException(TmdbFailure.forbidden, statusCode: 403);
    }
    if (statusCode == 404) {
      return const TmdbApiException(TmdbFailure.notFound, statusCode: 404);
    }
    if (statusCode != null) {
      return TmdbApiException(TmdbFailure.http, statusCode: statusCode);
    }
    if (error.error is FormatException || error.error is TypeError) {
      return const TmdbApiException.invalidResponse();
    }
    if (switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => true,
      _ => false,
    }) {
      return const TmdbApiException(TmdbFailure.timeout);
    }
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.badCertificate) {
      return const TmdbApiException(TmdbFailure.connection);
    }
    return const TmdbApiException(TmdbFailure.unexpected);
  }

  String get diagnostic => switch (failure) {
    TmdbFailure.configuration =>
      'Falta configurar THE_MOVIEDB_KEY para consultar TMDB.',
    TmdbFailure.connection =>
      'No se pudo conectar con TMDB. Verifica la conexión a Internet.',
    TmdbFailure.unauthorized => 'TMDB rechazó la autenticación (HTTP 401). Verifica la configuración de la API Key.',
    TmdbFailure.forbidden =>
      'TMDB denegó el acceso (HTTP 403). Verifica los permisos de la API Key.',
    TmdbFailure.notFound =>
      'TMDB no encontró el recurso solicitado (HTTP 404).',
    TmdbFailure.timeout => 'La solicitud a TMDB agotó el tiempo de espera.',
    TmdbFailure.invalidResponse =>
      'TMDB devolvió una respuesta inválida o con un formato inesperado.',
    TmdbFailure.http => 'TMDB respondió con HTTP $statusCode.',
    TmdbFailure.unexpected => 'Ocurrió un error inesperado al consultar TMDB.',
  };

  @override
  String toString() => diagnostic;
}
