import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

class DiscoverProvider extends ChangeNotifier {
  final VideoPostRepository forYouRepository;
  final VideoPostRepository nearYouRepository;
  final VideoPostRepository discoverRepository;

  bool initialLoading = true;
  List<VideoPost> forYouVideos = [];
  List<VideoPost> nearYouVideos = [];
  List<VideoPost> discoverVideos = [];

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

  Future<void> loadNextPage() async {
    initialLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        forYouRepository.getTrendingVideosByPage(1),
        nearYouRepository.getTrendingVideosByPage(1),
        discoverRepository.getTrendingVideosByPage(1),
      ]);

      forYouVideos = results[0];
      nearYouVideos = results[1];
      discoverVideos = results[2];
    } catch (_) {
      // Fallback seguro en caso de contingencias
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }
}
