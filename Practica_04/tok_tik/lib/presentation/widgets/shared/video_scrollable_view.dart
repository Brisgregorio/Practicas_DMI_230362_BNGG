import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatefulWidget {
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
  State<VideoScrollableView> createState() => _VideoScrollableViewState();
}

class _VideoScrollableViewState extends State<VideoScrollableView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.videos.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final pageView = PageView.builder(
      scrollDirection: Axis.vertical,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: widget.videos.length,
      onPageChanged: (index) {
        setState(() => _currentIndex = index);
        if (index >= widget.videos.length - 3 && widget.onLoadMore != null) {
          widget.onLoadMore!();
        }
      },
      itemBuilder: (context, index) {
        final VideoPost videoPost = widget.videos[index];

        return FullScreenPlayer(
          key: ValueKey('${index}_${videoPost.id}_${videoPost.videoUrl}'),
          video: videoPost,
          caption: videoPost.caption,
          videoUrl: videoPost.videoUrl,
          likes: videoPost.likes,
          views: videoPost.views,
          sectionTag: widget.sectionTag,
          accentColor: widget.accentColor,
          isActive: widget.isActive && index == _currentIndex,
          onLikeChanged: widget.onLikeChanged != null
              ? (isLiked, count) =>
                  widget.onLikeChanged!(videoPost, isLiked, count)
              : null,
        );
      },
    );

    if (widget.onRefresh != null) {
      return RefreshIndicator(
        color: widget.accentColor ?? const Color(0xFFFF2A54),
        backgroundColor: const Color(0xFF1E1E1E),
        strokeWidth: 2.5,
        onRefresh: widget.onRefresh!,
        child: pageView,
      );
    }

    return pageView;
  }
}
