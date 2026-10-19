import 'package:dio/dio.dart';
import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';

/// Datasource para la sección "Para ti" utilizando la API de Cloudinary.
/// Reproduce videos cortos verticales en formato 9:16 con PISTA DE AUDIO Y SONIDO REAL.
class CloudinaryVideoDatasource implements VideoPostDatasource {
  final Dio dio;

  CloudinaryVideoDatasource({Dio? client})
      : dio = client ??
            Dio(
              BaseOptions(
                baseUrl: 'https://res.cloudinary.com/demo/video',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  static const String _baseUrl = 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto';

  /// Catálogo curado de videos en Cloudinary con audio y pista musical/ambiental activa
  final List<Map<String, dynamic>> _audioVideos = [
    {
      'id': 'finish_line',
      'caption': '¡Llegada a la meta a toda velocidad! 🏁🔊 #ParaTi #Carreras',
      'videoUrl': '$_baseUrl/finish_line.mp4',
      'likes': 84210,
      'views': 412030,
    },
    {
      'id': 'forest_bike',
      'caption': 'Descenso extremo en bicicleta de montaña 🌲🚴 #ParaTi #Adrenalina',
      'videoUrl': '$_baseUrl/forest_bike.mp4',
      'likes': 193400,
      'views': 945000,
    },
    {
      'id': 'rafting',
      'caption': 'Aventura en los rápidos de aguas bravas 🌊🚣 #ParaTi #Extremo',
      'videoUrl': '$_baseUrl/rafting.mp4',
      'likes': 142300,
      'views': 682100,
    },
    {
      'id': 'snow_horses',
      'caption': 'Caballos salvajes galopando en la nieve ❄️🐎 #ParaTi #Naturaleza',
      'videoUrl': '$_baseUrl/snow_horses.mp4',
      'likes': 225900,
      'views': 1204000,
    },
    {
      'id': 'dog',
      'caption': 'El perrito más feliz del parque 🐶🎾 #ParaTi #Mascotas',
      'videoUrl': '$_baseUrl/dog.mp4',
      'likes': 312500,
      'views': 1850200,
    },
  ];

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError('Favoritos aún no tiene funcionalidad');
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    try {
      // Intentamos consultar la lista dinámica de recursos de la API pública de Cloudinary
      final response = await dio.get('/list/sample.json');
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final resources = response.data['resources'] as List<dynamic>?;
        if (resources != null && resources.isNotEmpty) {
          // Combinamos los recursos dinámicos con nuestra lista de videos con audio verificado
          final dynamicVideos = resources.map((res) {
            final publicId = res['public_id']?.toString() ?? 'dog';
            return VideoPost(
              caption: 'Video en tendencia: $publicId #ParaTi #Viral 🎵',
              videoUrl: '$_baseUrl/$publicId.mp4',
              likes: (res['version'] as int? ?? 12000) ~/ 10000,
              views: (res['version'] as int? ?? 50000) ~/ 1000,
            );
          }).toList();

          final staticVideos = _audioVideos.map((map) => VideoPost(
            caption: map['caption'],
            videoUrl: map['videoUrl'],
            likes: map['likes'],
            views: map['views'],
          )).toList();

          return [...staticVideos, ...dynamicVideos];
        }
      }
    } catch (_) {
      // Fallback inmediato a los videos verificados con sonido si la red tarda
    }

    return _audioVideos.map((map) => VideoPost(
      caption: map['caption'],
      videoUrl: map['videoUrl'],
      likes: map['likes'],
      views: map['views'],
    )).toList();
  }
}
