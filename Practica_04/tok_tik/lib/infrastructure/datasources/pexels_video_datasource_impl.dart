import 'package:dio/dio.dart';
import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';

/// Datasource para la sección "Descubrir" utilizando la API de Pexels Videos.
/// Proporciona videos verticales y de formato retrato para descubrir nuevas tendencias.
class PexelsVideoDatasource implements VideoPostDatasource {
  final Dio dio;
  final String apiKey;

  PexelsVideoDatasource({
    Dio? client,
    this.apiKey = '',
  }) : dio = client ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.pexels.com/v1/videos',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  /// Catálogo de videos de Pexels CDN y exploración temática (100% únicos, sin repetición)
  static const List<Map<String, dynamic>> _fallbackVideos = [
    {
      'caption': 'Nuevas tendencias de video en movimiento 🚀✨ #Descubrir #Viral',
      'videoUrl': 'https://videos.pexels.com/video-files/6274203/6274203-sd_426_226_30fps.mp4',
      'likes': 42800,
      'views': 310500,
    },
    {
      'caption': 'Estilo de vida urbano y perspectivas verticales 🏙️📱 #Descubrir #Lifestyle',
      'videoUrl': 'https://videos.pexels.com/video-files/5896379/5896379-sd_360_640_24fps.mp4',
      'likes': 56300,
      'views': 380400,
    },
    {
      'caption': 'Exploración cinemática y aventuras al aire libre 🏕️🌲 #Descubrir #Aventura',
      'videoUrl': 'https://videos.pexels.com/video-files/3195394/3195394-sd_640_360_25fps.mp4',
      'likes': 74100,
      'views': 520100,
    },
    {
      'caption': 'Expedición en el safari al atardecer 🐘🌅 #Descubrir #MundoSalvajer',
      'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/elephants.mp4',
      'likes': 178200,
      'views': 820300,
    },
    {
      'caption': 'Divertidas travesuras de gatitos en tendencia 🐱🐾 #Descubrir #Tendencia',
      'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/kitten_fighting.mp4',
      'likes': 420100,
      'views': 2300100,
    },
    {
      'caption': 'Descubriendo las profundidades del océano 🐢🌊 #Descubrir #Planeta',
      'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/sea_turtle.mp4',
      'likes': 189400,
      'views': 890400,
    },
  ];

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError('Favoritos aún no tiene funcionalidad');
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    if (apiKey.isNotEmpty) {
      try {
        final response = await dio.get(
          '/search',
          queryParameters: {
            'query': 'trending',
            'orientation': 'portrait',
            'per_page': 10,
            'page': page,
          },
          options: Options(
            headers: {
              'Authorization': apiKey,
            },
          ),
        );

        if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
          final videos = response.data['videos'] as List<dynamic>?;
          if (videos != null && videos.isNotEmpty) {
            return videos.map((item) {
              final videoFiles = item['video_files'] as List<dynamic>? ?? [];
              String videoUrl = '';
              for (final file in videoFiles) {
                if (file['file_type'] == 'video/mp4' && file['link'] != null) {
                  videoUrl = file['link'].toString();
                  break;
                }
              }

              final userName = item['user']?['name']?.toString() ?? 'Creador';
              final duration = (item['duration'] as int? ?? 10);

              return VideoPost(
                caption: 'Descubrimiento por $userName ✨ #Descubrir #TokTik',
                videoUrl: videoUrl,
                likes: duration * 2400,
                views: duration * 18500,
              );
            }).where((v) => v.videoUrl.isNotEmpty).toList();
          }
        }
      } catch (_) {
        // En caso de cuota excedida o falla de red, entra el fallback resiliente
      }
    }

    return _fallbackVideos.map((map) => VideoPost(
      caption: map['caption'],
      videoUrl: map['videoUrl'],
      likes: map['likes'],
      views: map['views'],
    )).toList();
  }
}
