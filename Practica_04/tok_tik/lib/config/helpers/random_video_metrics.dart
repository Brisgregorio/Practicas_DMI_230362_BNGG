import 'dart:math' as math;

/// Generador de métricas aleatorias y coherentes para videos de TokTik.
/// Cumple la regla lógica estricta: un video JAMÁS puede tener más likes que vistas (likes <= views < 1000).
class RandomVideoMetrics {
  static final math.Random _random = math.Random();

  /// Genera una cantidad aleatoria de likes y vistas menores a 1000.
  /// - `views`: Entre 60 y 990.
  /// - `likes`: Calculados como una fracción realista (15% - 70%) de las vistas.
  /// - Garantía absoluta: `likes <= views`.
  static ({int likes, int views}) generate({int maxCap = 1000}) {
    final cap = maxCap <= 1000 ? maxCap : 1000;
    
    // Vistas aleatorias menores a 1000 (entre 60 y cap - 5)
    final views = _random.nextInt(cap - 60) + 60;

    // Likes calculados como ratio realista de vistas (entre 15% y 70%)
    final ratio = 0.15 + (_random.nextDouble() * 0.55);
    int likes = (views * ratio).round();

    // Verificación de integridad lógica
    if (likes > views) {
      likes = views;
    }
    if (likes < 1) {
      likes = 1;
    }

    return (likes: likes, views: views);
  }
}
