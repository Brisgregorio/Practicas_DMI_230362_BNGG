import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;
  final String? sectionTag;
  final Color? accentColor;
  final bool isActive;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
    this.sectionTag,
    this.accentColor,
    this.isActive = true,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;
  bool isMuted = false;
  bool isPlaying = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    final isNetwork = widget.videoUrl.startsWith('http://') ||
        widget.videoUrl.startsWith('https://');

    controller = isNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        : VideoPlayerController.asset(widget.videoUrl);

    controller
      ..setLooping(true)
      ..setVolume(1.0); // SONIDO ACTIVO POR DEFECTO

    if (widget.isActive) {
      controller.play();
    }

    controller.addListener(() {
      if (mounted) {
        final currentlyPlaying = controller.value.isPlaying;
        if (currentlyPlaying != isPlaying) {
          setState(() {
            isPlaying = currentlyPlaying;
          });
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant FullScreenPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (!widget.isActive) {
        controller.pause();
      } else {
        controller.play();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      controller.setVolume(isMuted ? 0.0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.white70, size: 48),
                const SizedBox(height: 12),
                Text(
                  widget.caption,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }

        final size = controller.value.size;

        return GestureDetector(
          onTap: _togglePlayPause,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Video a pantalla completa (FittedBox para cover vertical)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: size.width > 0 ? size.width : 1080,
                    height: size.height > 0 ? size.height : 1920,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),

              // Gradiente para legibilidad
              VideoBackground(
                stops: const [0.7, 1.0],
              ),

              // Indicador animado de Pausa en el centro al pausar
              if (!isPlaying)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),

              // Botón de control de Audio/Sonido en la parte superior derecha (debajo del encabezado)
              Positioned(
                top: 102,
                right: 18,
                child: GestureDetector(
                  onTap: _toggleMute,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: (widget.accentColor ?? Colors.white).withValues(alpha: 0.6),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (widget.accentColor ?? Colors.white).withValues(alpha: 0.25),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                      color: isMuted ? Colors.white60 : (widget.accentColor ?? Colors.white),
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Texto e identificador de sección festiva en la parte inferior
              Positioned(
                bottom: 95,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.sectionTag != null) ...[
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: (widget.accentColor ?? Colors.white).withValues(alpha: 0.7),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 13,
                              color: widget.accentColor ?? Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.sectionTag!,
                              style: TextStyle(
                                color: widget.accentColor ?? Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    _VideoCaption(caption: widget.caption),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          shadows: const [
            Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1)),
          ],
        );

    return SizedBox(
      width: size.width * 0.65,
      child: Text(
        caption,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: titleStyle,
      ),
    );
  }
}
