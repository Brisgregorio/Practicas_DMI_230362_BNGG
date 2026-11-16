import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const _compileTimeMovieDbKey = String.fromEnvironment(
    'THE_MOVIEDB_KEY',
  );

  static String get theMovieDbKey {
    if (_compileTimeMovieDbKey.isNotEmpty) {
      return _compileTimeMovieDbKey.trim();
    }
    return dotenv.env['THE_MOVIEDB_KEY']?.trim() ?? '';
  }
}
