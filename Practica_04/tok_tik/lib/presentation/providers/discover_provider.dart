import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';
import 'package:toktik/infrastructure/datasources/local_storage_service.dart';

class DiscoverProvider extends ChangeNotifier {
  final VideoPostRepository forYouRepository;
  final VideoPostRepository nearYouRepository;
  final VideoPostRepository discoverRepository;

  bool initialLoading = true;
  bool isRefreshing = false;
  List<VideoPost> forYouVideos = [];
  List<VideoPost> nearYouVideos = [];
  List<VideoPost> discoverVideos = [];
  List<VideoPost> favoriteVideos = [];

  int _forYouPage = 1;
  int _nearYouPage = 1;
  int _discoverPage = 1;

  bool _loadingMoreForYou = false;
  bool _loadingMoreNearYou = false;
  bool _loadingMoreDiscover = false;

  /// Getter compatible con implementaciones previas
  List<VideoPost> get videos => forYouVideos;
  VideoPostRepository get videosRepository => forYouRepository;
  VideoPostRepository get videosRepositoy => forYouRepository;

  DiscoverProvider({
    VideoPostRepository? forYouRepository,
    VideoPostRepository? nearYouRepository,
    VideoPostRepository? discoverRepository,
    VideoPostRepository? videosRepositoy,
  })  : forYouRepository = forYouRepository ?? videosRepositoy!,
        nearYouRepository = nearYouRepository ?? (videosRepositoy ?? forYouRepository!),
        discoverRepository = discoverRepository ?? (videosRepositoy ?? forYouRepository!);

  /// Carga inicial al abrir la aplicación
  Future<void> loadNextPage() async {
    initialLoading = true;
    notifyListeners();

    try {
      _forYouPage = 1;
      _nearYouPage = 1;
      _discoverPage = 1;

      // 1. Inicializar Local Storage y cargar Favoritos guardados
      await LocalStorageService.init();
      favoriteVideos = await LocalStorageService.getFavoriteVideos();

      // 2. Obtener videos de las 3 APIs
      final results = await Future.wait([
        forYouRepository.getTrendingVideosByPage(1),
        nearYouRepository.getTrendingVideosByPage(1),
        discoverRepository.getTrendingVideosByPage(1),
      ]);

      // 3. Procesar sección 1 (Para ti)
      forYouVideos = _processSectionVideos(results[0], enforceZeroFirstVideo: true);

      // 4. Procesar sección 2 (Cerca de ti)
      nearYouVideos = _processSectionVideos(results[1], enforceZeroFirstVideo: true);

      // 5. Procesar sección 3 (Descubrir)
      discoverVideos = _processSectionVideos(results[2], enforceZeroFirstVideo: true);
    } catch (_) {
      // Fallback seguro en caso de contingencias
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  /// Función para refrescar el feed completo
  /// Requisito 1: Permite que videos actualizados vuelvan a salir en el feed
  /// Requisito 3: Muestra más videos variados al recargar el feed
  Future<void> refreshFeed() async {
    isRefreshing = true;
    notifyListeners();

    try {
      _forYouPage = 1;
      _nearYouPage = 1;
      _discoverPage = 1;

      // 1. Limpiar el registro de videos vistos para permitir refresco completo
      await LocalStorageService.clearViewedVideos();

      // 2. Cargar favoritos actualizados
      favoriteVideos = await LocalStorageService.getFavoriteVideos();

      // Breve pausa para dar fluidez a la animación de refresco
      await Future.delayed(const Duration(milliseconds: 350));

      final results = await Future.wait([
        forYouRepository.getTrendingVideosByPage(1),
        nearYouRepository.getTrendingVideosByPage(1),
        discoverRepository.getTrendingVideosByPage(1),
      ]);

      // 3. Barajar y procesar cada sección con videos frescos y variados
      final freshForYou = List<VideoPost>.from(results[0])..shuffle();
      final freshNearYou = List<VideoPost>.from(results[1])..shuffle();
      final freshDiscover = List<VideoPost>.from(results[2])..shuffle();

      forYouVideos = _processSectionVideos(freshForYou, enforceZeroFirstVideo: false);
      nearYouVideos = _processSectionVideos(freshNearYou, enforceZeroFirstVideo: false);
      discoverVideos = _processSectionVideos(freshDiscover, enforceZeroFirstVideo: false);
    } catch (_) {
      // Mantener videos existentes en caso de error
    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }

  /// Requisitos 1 y 2: Procesa videos sincronizando favoritos, filtrando vistos y aplicando regla de 0 likes/vistas
  List<VideoPost> _processSectionVideos(List<VideoPost> rawVideos, {required bool enforceZeroFirstVideo}) {
    if (rawVideos.isEmpty) return [];

    final viewedUrls = LocalStorageService.getViewedVideoUrls();

    // Requisito 1: Filtrar videos ya vistos si hay suficientes no vistos para evitar repetición
    List<VideoPost> filtered = rawVideos.where((v) => !viewedUrls.contains(v.videoUrl)).toList();
    if (filtered.length < 5) {
      // Si la mayoría ya fueron vistos, conservamos la lista completa para no quedarnos sin contenido
      filtered = List.from(rawVideos);
    }

    // Sincronizar estado de favoritos persistidos
    filtered = filtered.map((v) {
      final isFav = LocalStorageService.isFavorite(v.videoUrl);
      return v.copyWith(isLiked: isFav);
    }).toList();

    // Requisito 2: Al abrir la app en cualquier sección (menos favoritos),
    // SIEMPRE el primer video sale con 0 likes y 0 vistas
    // (sin sobreescribir datos en Local Storage)
    if (enforceZeroFirstVideo && filtered.isNotEmpty) {
      filtered[0] = filtered[0].copyWith(likes: 0, views: 0);
    }

    return filtered;
  }

  /// Requisito 6: Guarda o quita el like de un video, sincroniza favoritos y persiste en Local Storage
  Future<void> toggleLike(VideoPost video, bool isLiked, int newLikesCount) async {
    final updatedVideo = video.copyWith(isLiked: isLiked, likes: newLikesCount);

    // Actualizar en Local Storage
    if (isLiked) {
      await LocalStorageService.addFavorite(updatedVideo);
    } else {
      await LocalStorageService.removeFavorite(video.videoUrl);
    }

    // Recargar favoritos en memoria
    favoriteVideos = await LocalStorageService.getFavoriteVideos();

    // Sincronizar el video en las 3 secciones activas
    forYouVideos = _syncVideoInList(forYouVideos, updatedVideo);
    nearYouVideos = _syncVideoInList(nearYouVideos, updatedVideo);
    discoverVideos = _syncVideoInList(discoverVideos, updatedVideo);

    notifyListeners();
  }

  List<VideoPost> _syncVideoInList(List<VideoPost> list, VideoPost target) {
    return list.map((v) {
      if (v.videoUrl == target.videoUrl) {
        return v.copyWith(isLiked: target.isLiked, likes: target.likes);
      }
      return v;
    }).toList();
  }

  /// Función para cargar más videos automáticamente al scrollear hacia el final
  Future<void> loadMoreForSection(int sectionIndex) async {
    if (sectionIndex == 0) {
      if (_loadingMoreForYou) return;
      _loadingMoreForYou = true;
      try {
        _forYouPage++;
        final more = await forYouRepository.getTrendingVideosByPage(_forYouPage);
        final processed = more.map((v) => v.copyWith(isLiked: LocalStorageService.isFavorite(v.videoUrl))).toList();
        forYouVideos = [...forYouVideos, ...processed];
        notifyListeners();
      } catch (_) {
      } finally {
        _loadingMoreForYou = false;
      }
    } else if (sectionIndex == 1) {
      if (_loadingMoreNearYou) return;
      _loadingMoreNearYou = true;
      try {
        _nearYouPage++;
        final more = await nearYouRepository.getTrendingVideosByPage(_nearYouPage);
        final processed = more.map((v) => v.copyWith(isLiked: LocalStorageService.isFavorite(v.videoUrl))).toList();
        nearYouVideos = [...nearYouVideos, ...processed];
        notifyListeners();
      } catch (_) {
      } finally {
        _loadingMoreNearYou = false;
      }
    } else if (sectionIndex == 2) {
      if (_loadingMoreDiscover) return;
      _loadingMoreDiscover = true;
      try {
        _discoverPage++;
        final more = await discoverRepository.getTrendingVideosByPage(_discoverPage);
        final processed = more.map((v) => v.copyWith(isLiked: LocalStorageService.isFavorite(v.videoUrl))).toList();
        discoverVideos = [...discoverVideos, ...processed];
        notifyListeners();
      } catch (_) {
      } finally {
        _loadingMoreDiscover = false;
      }
    }
  }
}
