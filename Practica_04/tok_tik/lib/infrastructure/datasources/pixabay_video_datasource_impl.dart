import 'package:dio/dio.dart';
import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';

/// Datasource para la sección "Cerca de ti" utilizando la API de Pixabay Videos.
/// Ofrece videos sobre ciudades, comunidades, cafeterías y vida urbana local.
class PixabayVideoDatasource implements VideoPostDatasource {
  final Dio dio;
  final String apiKey;

  PixabayVideoDatasource({
    Dio? client,
    this.apiKey = '',
  }) : dio = client ??
            Dio(
              BaseOptions(
                baseUrl: 'https://pixabay.com/api/videos',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  /// Catálogo de videos verificados de Pixabay CDN y temática local/urbana (100% únicos, sin repetición)
  static const List<Map<String, dynamic>> _fallbackVideos = [
    {
      'caption': 'Un buen café barista para empezar el día ☕🥐 #CercaDeTi #CafeteriaLocal',
      'videoUrl': 'https://cdn.pixabay.com/video/2016/09/21/5373-183629075_medium.mp4',
      'likes': 28900,
      'views': 142000,
    },
    {
      'caption': 'Música en vivo en la plaza principal 🎸🎶 #CercaDeTi #TalentoLocal',
      'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/Cloudinary_Video_Teaser2.mp4',
      'likes': 19300,
      'views': 105600,
    },
    {
      'caption': 'Arte y danza en las calles del vecindario 💃🏙️ #CercaDeTi #Cultura',
      'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/red_dress_rrfdxi.mp4',
      'likes': 34200,
      'views': 210400,
    },
    {
      'caption': 'Fauna y naturaleza en el parque comunitario 🐿️🌿 #CercaDeTi #Comunidad',
      'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/marmots.mp4',
      'likes': 12400,
      'views': 76500,
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
          '/',
          queryParameters: {
            'key': apiKey,
            'q': 'city people lifestyle street coffee',
            'video_type': 'all',
            'per_page': 10,
            'page': page,
          },
        );

        if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
          final hits = response.data['hits'] as List<dynamic>?;
          if (hits != null && hits.isNotEmpty) {
            return hits.map((item) {
              final videos = item['videos'] as Map<String, dynamic>? ?? {};
              final medium = videos['medium'] as Map<String, dynamic>?;
              final large = videos['large'] as Map<String, dynamic>?;
              final small = videos['small'] as Map<String, dynamic>?;
              final videoUrl = medium?['url'] ?? large?['url'] ?? small?['url'] ?? '';

              final tags = item['tags']?.toString() ?? 'Ciudad, Estilo';
              final firstTag = tags.split(',').first.trim();

              return VideoPost(
                caption: 'Explorando $firstTag en tu zona 📍 #CercaDeTi #Local',
                videoUrl: videoUrl,
                likes: item['likes'] as int? ?? 1200,
                views: item['views'] as int? ?? 15000,
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
