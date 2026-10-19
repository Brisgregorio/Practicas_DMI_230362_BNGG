import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:toktik/config/helpers/human_formats.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/datasources/local_storage_service.dart';

class VideoButtons extends StatefulWidget {
  final VideoPost video;
  final bool isMuted;
  final VoidCallback? onToggleMute;
  final Color? accentColor;
  final Function(bool isLiked, int likesCount)? onLikeChanged;

  const VideoButtons({
    super.key,
    required this.video,
    this.isMuted = false,
    this.onToggleMute,
    this.accentColor,
    this.onLikeChanged,
  });

  @override
  State<VideoButtons> createState() => _VideoButtonsState();
}

class _VideoButtonsState extends State<VideoButtons>
    with SingleTickerProviderStateMixin {
  late bool isLiked;
  late int likesCount;
  late AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    isLiked = widget.video.isLiked || LocalStorageService.isFavorite(widget.video.videoUrl);
    likesCount = widget.video.likes;

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    if (!widget.isMuted) {
      _spinController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant VideoButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMuted != oldWidget.isMuted) {
      if (widget.isMuted) {
        _spinController.stop();
      } else {
        _spinController.repeat();
      }
    }
    if (widget.video.videoUrl != oldWidget.video.videoUrl) {
      isLiked = widget.video.isLiked || LocalStorageService.isFavorite(widget.video.videoUrl);
      likesCount = widget.video.likes;
    }
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likesCount += isLiked ? 1 : -1;
      if (likesCount < 0) likesCount = 0;
    });

    widget.onLikeChanged?.call(isLiked, likesCount);
  }

  @override
  Widget build(BuildContext context) {
    final Color themeAccent = widget.accentColor ?? const Color(0xFFFF2A54);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Botón de Corazón / Likes interactivo rediseñado
        _ActionItem(
          icon: isLiked ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          iconColor: isLiked ? Colors.redAccent : Colors.white,
          value: likesCount,
          accentColor: themeAccent,
          isHighlighted: isLiked,
          onTap: _toggleLike,
        ),

        const SizedBox(height: 18),

        // 2. Botón de Vistas rediseñado
        _ActionItem(
          icon: Icons.remove_red_eye_rounded,
          iconColor: Colors.white,
          value: widget.video.views,
          accentColor: themeAccent,
          onTap: null, // Informativo
        ),

        const SizedBox(height: 20),

        // 3. Botón de Disco Giratorio / Play con función de Mute / Unmute
        _RotatingDiscButton(
          controller: _spinController,
          isMuted: widget.isMuted,
          accentColor: themeAccent,
          onTap: widget.onToggleMute,
        ),
      ],
    );
  }
}

class _ActionItem extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final int value;
  final Color accentColor;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const _ActionItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.accentColor,
    this.isHighlighted = false,
    this.onTap,
  });

  @override
  State<_ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<_ActionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onTap != null) {
      _bounceController.forward(from: 0.0);
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _handleTap,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.isHighlighted
                      ? Colors.redAccent.withValues(alpha: 0.8)
                      : Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.isHighlighted
                        ? Colors.redAccent.withValues(alpha: 0.35)
                        : Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: 26,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          HumanFormats.humanReadbleNumber(widget.value.toDouble()),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1)),
            ],
          ),
        ),
      ],
    );
  }
}

class _RotatingDiscButton extends StatelessWidget {
  final AnimationController controller;
  final bool isMuted;
  final Color accentColor;
  final VoidCallback? onTap;

  const _RotatingDiscButton({
    required this.controller,
    required this.isMuted,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Disco vinilo giratorio
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFF2A2A2A),
                        Color(0xFF141414),
                        Color(0xFF0A0A0A),
                      ],
                      stops: [0.3, 0.7, 1.0],
                    ),
                    border: Border.all(
                      color: isMuted
                          ? Colors.white24
                          : accentColor.withValues(alpha: 0.8),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isMuted
                            ? Colors.black54
                            : accentColor.withValues(alpha: 0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    // Centro del disco estilo vinilo
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: isMuted
                            ? Colors.grey.shade800
                            : accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isMuted
                            ? Icons.volume_off_rounded
                            : Icons.music_note_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ),

              // Badge indicador de MUTE superpuesto cuando está silenciado
              if (isMuted)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.2),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 5),

          // Texto indicador Mute / Audio
          Text(
            isMuted ? 'Mute' : 'Audio',
            style: TextStyle(
              color: isMuted ? Colors.white60 : accentColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
