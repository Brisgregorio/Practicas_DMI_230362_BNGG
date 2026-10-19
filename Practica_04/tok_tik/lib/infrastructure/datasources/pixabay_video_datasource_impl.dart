import 'package:dio/dio.dart';
import 'package:toktik/config/helpers/random_video_metrics.dart';
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

 /// Catálogo ampliado con usernames, captions y descripciones largas para "Ver más"
 static const List<Map<String, dynamic>> _fallbackVideos = [
  {
   'userName': '@carlos_barista',
   'caption': 'Un buen café barista para empezar el día ',
   'description':
     'Un buen café barista para empezar el día Preparando un espresso perfecto con granos de origen local tostados artesanalmente. El aroma que inunda la cafetería de la esquina cada mañana es inconfundible. Ven a visitarnos en la calle central y disfruta de un momento de calma. #CercaDeTi #CafeteriaLocal #CafeArtesanal #BaristaLife',
   'videoUrl': 'https://cdn.pixabay.com/video/2016/09/21/5373-183629075_medium.mp4',
  },
  {
   'userName': '@vida_urbana_mx',
   'caption': 'Gente y vida cotidiana caminando por el centro ',
   'description':
     'Gente y vida cotidiana caminando por el centro El ritmo vibrante de nuestra ciudad capturado en una tarde soleada. Comerciantes, artistas y familias recorriendo los andadores peatonales con sonrisas y buena energía. #CercaDeTi #Comunidad #CentroHistorico #GenteLocal',
   'videoUrl': 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/face-demographics-walking.mp4',
  },
  {
   'userName': '@movilidad_verde',
   'caption': 'Ciclistas y tráfico ligero en la avenida local ‍',
   'description':
     'Ciclistas y tráfico ligero en la avenida local ‍ Cada día más vecinos eligen la bicicleta como medio de transporte ecológico y saludable. Apoyemos las ciclovías y el respeto mutuo entre peatones, ciclistas y automovilistas. #CercaDeTi #Movilidad #Ciclovia #CiudadVerde',
   'videoUrl': 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/person-bicycle-car-detection.mp4',
  },
  {
   'userName': '@acustico_plaza',
   'caption': 'Música en vivo en la plaza principal ',
   'description':
     'Música en vivo en la plaza principal Concierto improvisado que reunió a decenas de personas bajo la sombra de los laureles. El talento musical independiente florece en cada rincón de nuestro barrio. ¡Apoya siempre a los artistas locales! #CercaDeTi #TalentoLocal #MusicaEnVivo #PlazaPublica',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/Cloudinary_Video_Teaser2.mp4',
  },
  {
   'userName': '@danzarte_callejero',
   'caption': 'Arte y danza en las calles del vecindario ',
   'description':
     'Arte y danza en las calles del vecindario Una muestra coreográfica que combina folklore tradicional y expresión contemporánea. El movimiento y los colores vivos llenan de alegría a los transeúntes. #CercaDeTi #Cultura #DanzaUrbana #ArteEnLaCalle',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/red_dress_rrfdxi.mp4',
  },
  {
   'userName': '@amigos_del_parque',
   'caption': 'Fauna y naturaleza en el parque comunitario ',
   'description':
     'Fauna y naturaleza en el parque comunitario Las ardillas y aves silvestres disfrutando de una mañana tranquila entre los árboles centenarios. Cuidemos nuestras áreas verdes locales y mantengamos limpios los parques para todos. #CercaDeTi #ParqueLocal #NaturalezaUrbana #Comunidad',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/marmots.mp4',
  },
  {
   'userName': '@rutas_del_barrio',
   'caption': 'Paseo en automóvil por las calles del barrio ',
   'description':
     'Paseo en automóvil por las calles del barrio Descubriendo rincones pintorescos, murales coloridos y pequeñas tiendas de abarrotes con décadas de tradición. Cada callejón tiene una historia que contar. #CercaDeTi #EnTuZona #Tradicion #BarrioQuerido',
   'videoUrl': 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/car-detection.mp4',
  },
  {
   'userName': '@centro_juvenil_act',
   'caption': 'Talleres y actividades juveniles de la comunidad ',
   'description':
     'Talleres y actividades juveniles de la comunidad Clases gratuitas de arte, ciencia y robótica para los jóvenes del vecindario. La educación y la creatividad son las herramientas más poderosas para construir un futuro mejor. #CercaDeTi #Educacion #Juventud #ComunidadUnida',
   'videoUrl': 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/classroom.mp4',
  },
  {
   'userName': '@rostros_y_voces',
   'caption': 'Rostros y sonrisas de nuestros vecinos ',
   'description':
     'Rostros y sonrisas de nuestros vecinos Retratos espontáneos de personas trabajadoras que con su esfuerzo diario hacen grande a esta comunidad. La calidez humana es lo más valioso de nuestra zona. #CercaDeTi #GenteLocal #Sonrisas #OrgulloVecinal',
   'videoUrl': 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/head-pose-face-detection-female.mp4',
  },
  {
   'userName': '@tarde_de_cafe',
   'caption': 'Tarde de charla y café con amigos ',
   'description':
     'Tarde de charla y café con amigos Reencuentros memorables compartiendo risas, anécdotas y un buen trozo de pastel casero. Los momentos más sencillos son los que dejan huellas imborrables en el corazón. #CercaDeTi #Reunion #Amistad #MomentoCafe',
   'videoUrl': 'https://cdn.pixabay.com/video/2016/09/21/5373-183629075_medium.mp4',
  },
  {
   'userName': '@fiesta_patronal_tv',
   'caption': 'Festival vecinal de música y folklore ',
   'description':
     'Festival vecinal de música y folklore Trajes típicos, comparsas y el sonido de las bandas locales alegrando las calles adoquinadas. Mantener vivas nuestras raíces culturales es un compromiso de todos. #CercaDeTi #FiestaLocal #Folklore #TradicionesVivas',
   'videoUrl': 'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto/red_dress_rrfdxi.mp4',
  },
  {
   'userName': '@patinaje_urbano',
   'caption': 'Ruta matutina de patinadores y ciclistas ',
   'description':
     'Ruta matutina de patinadores y ciclistas Aprovechando el fresco de la mañana para ejercitarse y convivir en familia. El deporte al aire libre une a personas de todas las edades en un ambiente positivo. #CercaDeTi #DeporteLocal #VidaSaludable #ComunidadActiva',
   'videoUrl': 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/person-bicycle-car-detection.mp4',
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
     '/',
     queryParameters: {
      'key': apiKey,
      'q': 'city people lifestyle street coffee',
      'video_type': 'all',
      'per_page': 12,
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
       final metrics = RandomVideoMetrics.generate();

       return VideoPost(
        userName: '@${item['user']?.toString().replaceAll(' ', '_').toLowerCase() ?? 'vecino_local'}',
        caption: 'Explorando $firstTag en tu zona #CercaDeTi #Local',
        description: 'Explorando $firstTag en tu zona Recorrido especial mostrando los rincones más fascinantes y la esencia comunitaria de nuestro entorno local. #CercaDeTi #Comunidad #LocalVibes',
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
