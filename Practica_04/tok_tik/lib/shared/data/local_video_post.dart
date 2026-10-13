List<Map<String, dynamic>> videoPosts = [
  {
    'name': 'Subiendo escaleras automáticas',
    'videoUrl': 'assets/videos/1.mp4',
    'likes': 23230,
    'views': 1523,
  },
  {
    'name': 'Planta apreciada por peatones',
    'videoUrl': 'assets/videos/2.mp4',
    'likes': 24230,
    'views': 1343,
  },
  {
    'name': 'Que borroso veo todo!',
    'videoUrl': 'assets/videos/3.mp4',
    'likes': 21564320,
    'views': 123563,
  },
  {
    'name': '¿Esto es trigo? que interesante',
    'videoUrl': 'assets/videos/4.mp4',
    'likes': 320,
    'views': 2300,
  },
  {
    'name': 'El COVID no me afecta',
    'videoUrl': 'assets/videos/5.mp4',
    'likes': 3230,
    'views': 31030,
  },
  {
    'name': 'No quiero ir a trabajar hoy señor Stark',
    'videoUrl': 'assets/videos/6.mp4',
    'likes': 10,
    'views': 330,
  },
  {
    'name': 'Limpiar nunca fue tan divertido',
    'videoUrl': 'assets/videos/7.mp4',
    'likes': 1320,
    'views': 33032,
  },
  {
    'name': '¿Ya llegamos a la India?... umm si',
    'videoUrl': 'assets/videos/8.mp4',
    'likes': 342,
    'views': 3332,
  },
  {
    'name': '5 inutidatos de hollow knight',
    'videoUrl': 'assets/videos/9.mp4',
    'likes': 3200,
    'views': 4030,
  },
  {
    'name':'8 noticias randoms de hoy',
    'videoUrl': 'assets/videos/10.mp4',
    'likes': 2058,
    'views': 4800,
  },
  {
    'name':'Esa No Ñoño T-T',
    'videoUrl': 'assets/videos/11.mp4',
    'likes': 3058,
    'views': 7800,
  },
  {
    'name':'Giant Duels',
    'videoUrl': 'assets/videos/12.mp4',
    'likes': 7058,
    'views': 12000,
  },
  {
    'name':'Mr. Yi vs Sett',
    'videoUrl': 'assets/videos/13.mp4',
    'likes': 3058,
    'views': 4800,
  }


];

import 'package:tok_tik/domain/entities/video_post.dart';

class LocalVideoModel {
  final String name;
  final String videoUrl;
  final int likes;
  final int views;

  LocalVideoModel({
    required this.name,
    required this.videoUrl,
    required this.likes,
    required this.views,
  });

  factory LocalVideoModel.fromJson(Map<String, dynamic> json) {
    return LocalVideoModel(
      name: json['name'] as String? ?? '',
      videoUrl: json['videoUrl'] as String? ?? '',
      likes: json['likes'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
    );
  }

  VideoPost toVideoPostEntity() {
    return VideoPost(
      id: videoUrl,
      caption: name,
      videoUrl: videoUrl,
      likes: likes,
      isLiked: false,
      source: 'local',
    );
  }
}
