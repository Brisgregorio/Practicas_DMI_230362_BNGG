import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;
  final String? sectionTag;
  final Color? accentColor;
  final bool isActive;
  final VoidCallback? onLoadMore;
  final Future<void> Function()? onRefresh;
  final Function(VideoPost video, bool isLiked, int likesCount)? onLikeChanged;

  const VideoScrollableView({
    super.key,
    required this.videos,
    this.sectionTag,
    this.accentColor,
    this.isActive = true,
    this.onLoadMore,
    this.onRefresh,
    this.onLikeChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final pageView = PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: videos.length,
      onPageChanged: (index) {
        if (index >= videos.length - 3 && onLoadMore != null) {
          onLoadMore!();
        }
      },
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];

        return FullScreenPlayer(
          video: videoPost,
          caption: videoPost.caption,
          videoUrl: videoPost.videoUrl,
          likes: videoPost.likes,
          views: videoPost.views,
          sectionTag: sectionTag,
          accentColor: accentColor,
          isActive: isActive,
          onLikeChanged: onLikeChanged != null
              ? (isLiked, count) => onLikeChanged!(videoPost, isLiked, count)
              : null,
        );
      },
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        color: accentColor ?? const Color(0xFFFF2A54),
        backgroundColor: const Color(0xFF1E1E1E),
        strokeWidth: 2.5,
        onRefresh: onRefresh!,
        child: pageView,
      );
    }

    return pageView;
  }
}
