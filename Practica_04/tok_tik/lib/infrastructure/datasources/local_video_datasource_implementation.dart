import 'package:tok_tik/domain/datasources/video_post_datasource.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/shared/data/local_video_post.dart';

class LocalVideoDatasource implements VideoPostDatasource {
  @override
  Future<List<VideoPost>> getForYouVideosByPage(int page) async {
    await Future.delayed(const Duration(seconds: 2));
    return _getLocalVideos();
  }

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) async {
  final videos = _getLocalVideos();

  return videos.where((video) => video.isLiked).toList();
}

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    await Future.delayed(const Duration(seconds: 2));
    return _getLocalVideos();
  }

  List<VideoPost> _getLocalVideos() {
    return videoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();
  }
}
