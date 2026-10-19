import 'package:dio/dio.dart';
import 'package:toktik/config/helpers/random_video_metrics.dart';
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

 /// Catálogo ampliado con usernames, captions y descripciones largas para "Ver más"
 static const List<Map<String, dynamic>> _fallbackVideos = [
  {
   'userName': '@creative_motion',
   'caption': 'Nuevas tendencias de video en movimiento ',
   'description':
     'Nuevas tendencias de video en movimiento Explorando efectos de transición fluida, encuadres dinámicos y color grading cinematográfico para crear contenido visual de alto impacto. La innovación no se detiene en TokTik. #Descubrir #Viral #CreadoresDigitales #Tendencia2026',
   'videoUrl': 'https://videos.pexels.com/video-files/6274203/6274203-sd_426_226_30fps.mp4',
  },
  {
   'userName': '@urban_vibes_daily',
   'caption': 'Estilo de vida urbano y perspectivas verticales ',
   'description':
     'Estilo de vida urbano y perspectivas verticales El contraste arquitectónico entre los rascacielos modernos y las calles llenas de vida. Cada ángulo ofrece una perspectiva diferente del pulso cosmopolita. #Descubrir #Lifestyle #Ciudad #FotografiaUrbana',
   'videoUrl': 'https://videos.pexels.com/video-files/5896379/5896379-sd_360_640_24fps.mp4',
  },
  {
   'userName': '@senderos_del_mundo',
   'caption': 'Exploración cinemática y aventuras al aire libre ',
   'description':
     'Exploración cinemática y aventuras al aire libre Una caminata solitaria en medio de la niebla matutina. La paz de conectar con el silencio del bosque y alejarse del ruido cotidiano es una terapia que todos necesitamos. #Descubrir #Aventura #Naturaleza #CampingLife',
   'videoUrl': 'https://videos.pexels.com/video-files/3195394/3195394-sd_640_360_25fps.mp4',
  },
  {
   'userName': '@visual_art_hub',
   'caption': 'Creatividad visual y estética en alta definición ',
   'description':
     'Creatividad visual y estética en alta definición Experimentación con iluminación suave, texturas orgánicas y planos detalle que transforman lo ordinario en una obra de arte visual cautivadora. #Descubrir #Trending #ArteVisual #Cinematografia',
   'videoUrl': 'https://videos.pexels.com/video-files/4434242/4434242-sd_360_640_24fps.mp4',
  },
  {
   'userName': '@skate_session_pro',
   'caption': 'Trucos y maniobras de skate en el parque ',
   'description':
     'Trucos y maniobras de skate en el parque Grind en los barandales de metal y aterrizajes limpios en la rampa grande. La perseverancia detrás de cada truco fallido hasta lograr la toma perfecta. ¡Pura pasión sobre cuatro ruedas! #Descubrir #SkateLife #Extremo #StreetStyle',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/skate.mp4',
  },
  {
   'userName': '@safari_expedition',
   'caption': 'Expedición en el safari al atardecer ',
   'description':
     'Expedición en el safari al atardecer El sol cayendo lentamente sobre la sabana mientras los gigantes gentiles cruzan el río. Un recordatorio imponente de la majestuosidad y fragilidad de nuestro planeta. #Descubrir #MundoSalvaje #Safari #FaunaSalvaje',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/elephants.mp4',
  },
  {
   'userName': '@gatitos_tiernos_tv',
   'caption': 'Divertidas travesuras de gatitos en tendencia ',
   'description':
     'Divertidas travesuras de gatitos en tendencia Estos pequeños felinos no paran de jugar y perseguirse por toda la sala. Sus ocurrencias espontáneas le alegran el día a cualquiera. ¿Tienes gatos en casa? Comenta su nombre abajo. #Descubrir #Tendencia #Gatitos #CatLovers',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/kitten_fighting.mp4',
  },
  {
   'userName': '@ocean_blue_world',
   'caption': 'Descubriendo las profundidades del océano ',
   'description':
     'Descubriendo las profundidades del océano Nadando junto a una tortuga marina ancestral en las aguas cristalinas del arrecife. La serenidad del mundo submarino es un tesoro invaluable que debemos proteger. #Descubrir #Planeta #Oceano #VidaMarina',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/sea_turtle.mp4',
  },
  {
   'userName': '@curious_whiskers',
   'caption': 'El gato más curioso explorando su entorno ',
   'description':
     'El gato más curioso explorando su entorno Cada rincón, caja o sombra es un misterio por resolver para este pequeño cazador de miradas atentas. La elegancia y misterio de los gatos nunca dejan de asombrarnos. #Descubrir #Animales #Felinos #CutePets',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/cat.mp4',
  },
  {
   'userName': '@skate_slowmo',
   'caption': 'Piruetas y saltos de skate en cámara lenta ',
   'description':
     'Piruetas y saltos de skate en cámara lenta Detallando la rotación perfecta de la tabla a 120 cuadros por segundo. La técnica y el equilibrio desafiando la gravedad en el skatepark metropolitano. #Descubrir #Extremo #SlowMotion #Skater',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/skate.mp4',
  },
  {
   'userName': '@wildlife_voices',
   'caption': 'Manada de elefantes en su hábitat natural ',
   'description':
     'Manada de elefantes en su hábitat natural Madres cuidando a sus crías y enseñándoles los senderos migratorios que han recorrido por generaciones. La sabiduría de la naturaleza es infinita. #Descubrir #VidaSalvaje #PlanetaTierra #Conservacion',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/elephants.mp4',
  },
  {
   'userName': '@coral_reef_project',
   'caption': 'Navegando entre corales y fauna marina ',
   'description':
     'Navegando entre corales y fauna marina Una explosión de colores bajo el mar tropical. Miles de especies conviviendo en armonía en uno de los ecosistemas más diversos y fascinantes de la Tierra. #Descubrir #OceanVibes #Arrecife #Buceo',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/sea_turtle.mp4',
  },
 ];

 @override
 Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
  throw UnimplementedError('Favoritos se gestiona desde el LocalStorageService');
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
      'per_page': 12,
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
       final metrics = RandomVideoMetrics.generate();

       return VideoPost(
        userName: '@${userName.replaceAll(' ', '_').toLowerCase()}',
        caption: 'Descubrimiento por $userName #Descubrir #TokTik',
        description: 'Descubrimiento por $userName Explorando nuevas tendencias creativas, momentos inolvidables y lo más viral del momento en formato vertical. #Descubrir #TokTikViral #TrendingVideo',
        videoUrl: videoUrl,
        likes: metrics.likes,
        views: metrics.views,
       );
      }).where((v) => v.videoUrl.isNotEmpty).toList();
     }
    }
   } catch (_) {
    // En caso de cuota excedida o falla de red, entra el fallback resiliente
   }
  }

  return _fallbackVideos.map((map) {
   final metrics = RandomVideoMetrics.generate();
   final pageSuffix = page > 1 ? ' (Pág. $page)' : '';

   return VideoPost(
    userName: map['userName'] as String?,
    caption: '${map['caption']}$pageSuffix',
    description: '${map['description']}$pageSuffix',
    videoUrl: map['videoUrl'] as String,
    likes: metrics.likes,
    views: metrics.views,
   );
  }).toList();
 }
}
