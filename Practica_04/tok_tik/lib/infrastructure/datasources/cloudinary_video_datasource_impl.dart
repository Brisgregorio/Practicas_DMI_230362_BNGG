import 'package:dio/dio.dart';
import 'package:toktik/config/helpers/random_video_metrics.dart';
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

 static const String _baseUrl =
   'https://res.cloudinary.com/demo/video/upload/ar_9:16,c_fill,g_auto';

 /// Catálogo de videos con audio real, usernames y descripciones completas
 static final List<Map<String, dynamic>> _catalog = [
  {
   'id': 'finish_line',
   'userName': '@marcos_speed',
   'caption': '¡Llegada a la meta a toda velocidad! ',
   'description':
     '¡Llegada a la meta a toda velocidad! Cruzando la bandera a cuadros tras 50 vueltas intensas bajo la lluvia. Los motores rugieron al máximo en esta final de campeonato inolvidable. Deja tu like si apoyas las carreras de velocidad y la adrenalina pura. #ParaTi #Carreras #Velocidad #Motorsport',
   'videoUrl': '$_baseUrl/finish_line.mp4',
  },
  {
   'id': 'forest_bike',
   'userName': '@sofia_mountain',
   'caption': 'Descenso extremo en bicicleta de montaña ',
   'description':
     'Descenso extremo en bicicleta de montaña Ruta técnica en los senderos más empinados del bosque nacional. Rocas, raíces y curvas cerradas que pusieron a prueba los frenos y la suspensión. ¿Te atreverías a bajar este sendero sin frenar? #ParaTi #MTB #Adrenalina #AventuraExtrema',
   'videoUrl': '$_baseUrl/forest_bike.mp4',
  },
  {
   'id': 'rafting',
   'userName': '@rio_bravo_team',
   'caption': 'Aventura en los rápidos de aguas bravas ',
   'description':
     'Aventura en los rápidos de aguas bravas Desafiando la corriente de clase 5 en el cañón principal. La coordinación del equipo fue clave para no volcar en el remolino. ¡Una de las mejores experiencias acuáticas del año! #ParaTi #Rafting #Extremo #AguasBravas',
   'videoUrl': '$_baseUrl/rafting.mp4',
  },
  {
   'id': 'snow_horses',
   'userName': '@valle_salvaje',
   'caption': 'Caballos salvajes galopando en la nieve ',
   'description':
     'Caballos salvajes galopando en la nieve Una estampa mágica capturada al amanecer en las praderas nevadas. La fuerza, libertad y elegancia de estos animales en su hábitat invernal es un espectáculo visual único en el mundo. #ParaTi #Naturaleza #Caballos #InviernoMagico',
   'videoUrl': '$_baseUrl/snow_horses.mp4',
  },
  {
   'id': 'dog',
   'userName': '@max_el_golden',
   'caption': 'El perrito más feliz del parque ',
   'description':
     'El perrito más feliz del parque Nada supera la emoción de correr tras la pelota favorita por horas en el pasto verde. ¡Energía inagotable y pura felicidad perruna contagiando a todos! Síguenos para más momentos adorables. #ParaTi #Mascotas #GoldenRetriever #PerritoViral',
   'videoUrl': '$_baseUrl/dog.mp4',
  },
  {
   'id': 'finish_line_2',
   'userName': '@racing_pro_pilot',
   'caption': 'Derrapes y adrenalina en la última curva ',
   'description':
     'Derrapes y adrenalina en la última curva Quemando llanta y rozando los límites de adherencia para conseguir la pole position. El sonido del turbo y el rugir del escape son pura música para los amantes del automovilismo deportivo. #ParaTi #Drift #Velocidad #Supercars',
   'videoUrl': '$_baseUrl/finish_line.mp4',
  },
  {
   'id': 'forest_bike_2',
   'userName': '@alex_downhill',
   'caption': 'Saltos acrobáticos en el sendero del bosque ',
   'description':
     'Saltos acrobáticos en el sendero del bosque Volando sobre los saltos de tierra con precisión milimétrica al atardecer. Cada aterrizaje perfecto es el resultado de meses de práctica constante. #ParaTi #Bikers #Saltos #BosqueExtremo',
   'videoUrl': '$_baseUrl/forest_bike.mp4',
  },
  {
   'id': 'rafting_2',
   'userName': '@kayak_adventures',
   'caption': 'Maniobra extrema desafiando la corriente ',
   'description':
     'Maniobra extrema desafiando la corriente El agua helada salpicando en cada remada mientras surfeamos olas gigantes en el río. La adrenalina de enfrentar la fuerza salvaje de la naturaleza. #ParaTi #TeamWork #AventuraAcuatica #Adrenalina',
   'videoUrl': '$_baseUrl/rafting.mp4',
  },
  {
   'id': 'snow_horses_2',
   'userName': '@patagonia_wild',
   'caption': 'Tropa de corceles cruzando el valle helado ',
   'description':
     'Tropa de corceles cruzando el valle helado El sonido de los cascos resonando en el silencio de las montañas nevadas. Una danza de libertad y belleza que solo la naturaleza salvaje puede regalarnos. #ParaTi #Magia #VidaSalvaje #Montañas',
   'videoUrl': '$_baseUrl/snow_horses.mp4',
  },
  {
   'id': 'dog_2',
   'userName': '@canine_tricks',
   'caption': 'Acrobacias y saltos caninos en cámara rápida ',
   'description':
     'Acrobacias y saltos caninos en cámara rápida Un entrenamiento divertido lleno de saltos de vallas, giros en el aire y atrapadas espectaculares de frisbee. El mejor amigo del hombre demostrando su gran talento atlético. #ParaTi #ViralDog #Acrobacias #DogLovers',
   'videoUrl': '$_baseUrl/dog.mp4',
  },
  {
   'id': 'finish_line_3',
   'userName': '@grand_prix_tv',
   'caption': 'Celebración en el podio tras una carrera épica ',
   'description':
     'Celebración en el podio tras una carrera épica Champagne en el aire, trofeo dorado en mano y la ovación de miles de fanáticos en las tribunas. Todo el esfuerzo de la temporada resumido en un instante glorioso de victoria. #ParaTi #Ganadores #Campeon #Motorsport',
   'videoUrl': '$_baseUrl/finish_line.mp4',
  },
  {
   'id': 'forest_bike_3',
   'userName': '@sunset_riders',
   'caption': 'Ruta de montaña al atardecer ‍',
   'description':
     'Ruta de montaña al atardecer ‍ La luz dorada filtrándose entre los árboles mientras pedaleamos hacia la cima. La recompensa de la vista panorámica hace que cada gota de sudor valga la pena. #ParaTi #Pasion #GoldenHour #CyclingLife',
   'videoUrl': '$_baseUrl/forest_bike.mp4',
  },
 ];

 @override
 Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
  throw UnimplementedError('Favoritos se gestiona desde el LocalStorageService');
 }

 @override
 Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
  // Generar videos con métricas aleatorias < 1000 y asegurando que likes <= views
  return _catalog.map((item) {
   final metrics = RandomVideoMetrics.generate();
   final pageSuffix = page > 1 ? ' (Parte $page)' : '';

   return VideoPost(
    id: '${item['id']}_p$page',
    userName: item['userName'],
    caption: '${item['caption']}$pageSuffix',
    description: '${item['description']}$pageSuffix',
    videoUrl: item['videoUrl'],
    likes: metrics.likes,
    views: metrics.views,
   );
  }).toList();
 }
}
