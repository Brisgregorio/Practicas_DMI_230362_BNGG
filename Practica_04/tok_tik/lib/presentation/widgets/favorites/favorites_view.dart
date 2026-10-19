import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktik/config/theme/season_config.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class FavoritesView extends StatelessWidget {
  final List<VideoPost> favoriteVideos;
  final AppSeason season;
  final VoidCallback onExplorePressed;
  final bool isActive;
  final Function(VideoPost video, bool isLiked, int likesCount)? onLikeChanged;

  const FavoritesView({
    super.key,
    required this.season,
    required this.onExplorePressed,
    this.favoriteVideos = const [],
    this.isActive = false,
    this.onLikeChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteVideos.isNotEmpty) {
      return VideoScrollableView(
        videos: favoriteVideos,
        sectionTag: 'Favoritos (${favoriteVideos.length})',
        accentColor: season.accentColor,
        isActive: isActive,
        onLikeChanged: onLikeChanged,
      );
    }
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Aura brillante estacional de fondo
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.2,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: season.accentColor.withValues(alpha: 0.12),
                boxShadow: [
                  BoxShadow(
                    color: season.accentColor.withValues(alpha: 0.2),
                    blurRadius: 90,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // Contenido centrado
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icono festivo animado
                  BounceInDown(
                    duration: const Duration(milliseconds: 700),
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: season.accentColor.withValues(alpha: 0.15),
                        border: Border.all(
                          color: season.accentColor.withValues(alpha: 0.6),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 48,
                        color: season.accentColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Título
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: const Text(
                      'Tus Favoritos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtítulo con adaptación a la fecha festiva
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'Aún no tienes videos guardados como favoritos.\nPronto podrás guardar los videos más destacados de esta temporada de ${season.displayName}.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                        height: 1.45,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Chip festivo informativo
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: season.accentColor.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: season.accentColor.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              season.logoAsset,
                              width: 16,
                              height: 16,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Temporada ${season.displayName}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: season.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Botón para volver a explorar videos
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: ElevatedButton.icon(
                      onPressed: onExplorePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: season.accentColor,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: season.accentColor.withValues(alpha: 0.5),
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded, size: 22),
                      label: const Text(
                        'Explorar videos en Para ti',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
