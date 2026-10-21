import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toktik/domain/entities/video_post.dart';

/// Servicio de almacenamiento local (Local Storage) para TokTik.
/// Gestiona la persistencia de videos vistos, conteo de likes y vistas,
/// y la lista de videos favoritos guardados por el usuario.
class LocalStorageService {
  static const String _keyFavorites = 'toktik_favorite_videos';
  static const String _keyViewed = 'toktik_viewed_videos';
  static const String _keyVideoMuted = 'toktik_video_muted';
  static final ValueNotifier<bool> videoMuted = ValueNotifier<bool>(false);

  // Memoria caché para acceso ultrarrápido y fallback seguro
  static final Map<String, VideoPost> _favoritesCache = {};
  static final Map<String, Map<String, dynamic>> _viewedCache = {};
  static bool _initialized = false;

  /// Inicializa la lectura del almacenamiento local al arrancar la app
  static Future<void> init() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      videoMuted.value = prefs.getBool(_keyVideoMuted) ?? false;

      // Cargar favoritos persistidos
      final favoritesRaw = prefs.getStringList(_keyFavorites) ?? [];
      _favoritesCache.clear();
      for (final item in favoritesRaw) {
        try {
          final map = jsonDecode(item) as Map<String, dynamic>;
          final video = VideoPost.fromJson(map).copyWith(isLiked: true);
          _favoritesCache[video.videoUrl] = video;
        } catch (_) {}
      }

      // Cargar videos vistos persistidos
      final viewedRaw = prefs.getString(_keyViewed);
      if (viewedRaw != null) {
        final decoded = jsonDecode(viewedRaw) as Map<String, dynamic>;
        _viewedCache.clear();
        decoded.forEach((key, val) {
          if (val is Map<String, dynamic>) {
            _viewedCache[key] = val;
          }
        });
      }

      _initialized = true;
    } catch (_) {
      _initialized = true;
    }
  }

  /// Keeps the user's mute choice consistent across video controllers and launches.
  static Future<void> setVideoMuted(bool muted) async {
    videoMuted.value = muted;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyVideoMuted, muted);
    } catch (_) {}
  }

  /// 1. Almacena un video visto en el Local Storage con sus likes y vistas
  static Future<void> saveViewedVideo(VideoPost video) async {
    await init();
    final data = {
      'id': video.id,
      'videoUrl': video.videoUrl,
      'likes': video.likes,
      'views': video.views,
      'userName': video.userName,
      'caption': video.caption,
      'description': video.description,
      'viewedAt': DateTime.now().toIso8601String(),
    };

    _viewedCache[video.videoUrl] = data;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyViewed, jsonEncode(_viewedCache));
    } catch (_) {}
  }

  /// Verifica si un video ya fue visto
  static bool isVideoViewed(String videoUrl) {
    return _viewedCache.containsKey(videoUrl);
  }

  /// Obtiene los identificadores/URLs de todos los videos vistos
  static Set<String> getViewedVideoUrls() {
    return _viewedCache.keys.toSet();
  }

  /// Limpia los videos vistos al recargar/actualizar el feed para permitir que vuelvan a salir
  static Future<void> clearViewedVideos() async {
    await init();
    _viewedCache.clear();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyViewed);
    } catch (_) {}
  }

  /// Obtiene los datos persistidos de un video visto si existen
  static Map<String, dynamic>? getViewedVideoData(String videoUrl) {
    return _viewedCache[videoUrl];
  }

  /// 6. Guarda o elimina un video de la lista de Favoritos con persistencia
  static Future<bool> toggleFavorite(VideoPost video) async {
    await init();
    final url = video.videoUrl;

    if (_favoritesCache.containsKey(url)) {
      // Si ya era favorito, se elimina de favoritos
      _favoritesCache.remove(url);
      await _persistFavorites();
      return false;
    } else {
      // Se añade a favoritos con isLiked = true y manteniendo likes y vistas
      final favVideo = video.copyWith(isLiked: true);
      _favoritesCache[url] = favVideo;
      await _persistFavorites();
      return true;
    }
  }

  /// Guarda explícitamente un video en favoritos
  static Future<void> addFavorite(VideoPost video) async {
    await init();
    _favoritesCache[video.videoUrl] = video.copyWith(isLiked: true);
    await _persistFavorites();
  }

  /// Remueve un video de favoritos
  static Future<void> removeFavorite(String videoUrl) async {
    await init();
    _favoritesCache.remove(videoUrl);
    await _persistFavorites();
  }

  /// Comprueba si un video es favorito actualmente
  static bool isFavorite(String videoUrl) {
    return _favoritesCache.containsKey(videoUrl);
  }

  /// Devuelve la lista completa de videos favoritos guardados
  static Future<List<VideoPost>> getFavoriteVideos() async {
    await init();
    return _favoritesCache.values.toList();
  }

  /// Helper interno para guardar los favoritos en SharedPreferences
  static Future<void> _persistFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list =
          _favoritesCache.values.map((v) => jsonEncode(v.toJson())).toList();
      await prefs.setStringList(_keyFavorites, list);
    } catch (_) {}
  }
}
