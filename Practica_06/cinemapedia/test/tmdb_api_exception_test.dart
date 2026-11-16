import 'package:cinemapedia/infrastructure/datasources/tmdb_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TmdbApiException', () {
    test(
      'classifies authentication, permission, and not found HTTP errors',
      () {
        expect(
          TmdbApiException.fromDio(_httpError(401)).failure,
          TmdbFailure.unauthorized,
        );
        expect(
          TmdbApiException.fromDio(_httpError(403)).failure,
          TmdbFailure.forbidden,
        );
        expect(
          TmdbApiException.fromDio(_httpError(404)).failure,
          TmdbFailure.notFound,
        );
      },
    );

    test('classifies connection and timeout failures', () {
      final connectionError = DioException(
        requestOptions: RequestOptions(path: '/movie/popular'),
        type: DioExceptionType.connectionError,
      );
      final timeoutError = DioException(
        requestOptions: RequestOptions(path: '/movie/popular'),
        type: DioExceptionType.receiveTimeout,
      );

      expect(
        TmdbApiException.fromDio(connectionError).failure,
        TmdbFailure.connection,
      );
      expect(
        TmdbApiException.fromDio(timeoutError).failure,
        TmdbFailure.timeout,
      );
    });

    test('diagnostics do not include request query parameters', () {
      final error = TmdbApiException.fromDio(_httpError(401));

      expect(error.diagnostic, contains('HTTP 401'));
      expect(error.diagnostic, isNot(contains('api_key')));
      expect(error.diagnostic, isNot(contains('secret')));
    });

    test('identifies invalid responses', () {
      expect(
        const TmdbApiException.invalidResponse().failure,
        TmdbFailure.invalidResponse,
      );
    });
  });
}

DioException _httpError(int statusCode) {
  return DioException(
    requestOptions: RequestOptions(path: '/movie/popular'),
    response: Response(
      requestOptions: RequestOptions(path: '/movie/popular'),
      statusCode: statusCode,
    ),
    type: DioExceptionType.badResponse,
  );
}
