import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/datasources/local_storage_service.dart';
import 'package:toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;
  final int likes;
  final int views;
  final VideoPost? video;
  final String? sectionTag;
  final Color? accentColor;
  final bool isActive;
  final Function(bool isLiked, int likesCount)? onLikeChanged;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
    this.likes = 0,
    this.views = 0,
    this.video,
    this.sectionTag,
    this.accentColor,
    this.isActive = true,
    this.onLikeChanged,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;
  late Future<void> _initializeFuture;
  bool isMuted = false;
  bool isPlaying = true;
  bool showMuteNotice = false;
  Timer? _muteNoticeTimer;

  VideoPost get _effectiveVideo =>
      widget.video ??
      VideoPost(
        caption: widget.caption,
        videoUrl: widget.videoUrl,
        likes: widget.likes,
        views: widget.views,
      );

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
      ..setVolume(1.0); // Sonido activo por defecto

    // Inicializar UNA SOLA VEZ para evitar que pause/play reinicie la inicialización
    _initializeFuture = controller.initialize().then((_) {
      if (mounted) {
        if (widget.isActive) {
          controller.play();
          // Registrar video visto en Local Storage con sus likes y vistas
          LocalStorageService.saveViewedVideo(_effectiveVideo);
        }
        setState(() {});
      }
    });

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
        if (isPlaying) {
          controller.play();
        }
        // Registrar video visto cuando pasa a estar activo
        LocalStorageService.saveViewedVideo(_effectiveVideo);
      }
    }
  }

  @override
  void dispose() {
    _muteNoticeTimer?.cancel();
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
      showMuteNotice = true;
    });

    _muteNoticeTimer?.cancel();
    _muteNoticeTimer = Timer(const Duration(milliseconds: 1400), () {
      if (mounted) {
        setState(() {
          showMuteNotice = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveVideo = _effectiveVideo;

    return FutureBuilder(
      future: _initializeFuture,
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

        // Mientras no esté inicializado, mostramos el indicador inicial (solo al cargar por primera vez)
        if (!controller.value.isInitialized) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }

        final size = controller.value.size;

        return GestureDetector(
          onTap: _togglePlayPause,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Video a pantalla completa (BoxFit.cover para pantalla inmersiva)
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

              // 2. Gradiente inferior para legibilidad de títulos y controles
              VideoBackground(
                stops: const [0.65, 1.0],
              ),

              // 3. Indicador de Pausa animado en el centro (solo cuando el usuario pausa)
              if (!isPlaying)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),

              // 4. Aviso flotante temporal al mutear / desmutear el video
              if (showMuteNotice)
                Center(
                  child: AnimatedOpacity(
                    opacity: showMuteNotice ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: (widget.accentColor ?? Colors.white).withValues(alpha: 0.6),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                            color: isMuted ? Colors.redAccent : (widget.accentColor ?? Colors.white),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isMuted ? 'Audio silenciado' : 'Audio activado',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // 5. Botones laterales rediseñados (Corazón, Vistas y Disco Giratorio con Mute)
              Positioned(
                bottom: 85,
                right: 14,
                child: VideoButtons(
                  video: effectiveVideo,
                  isMuted: isMuted,
                  onToggleMute: _toggleMute,
                  accentColor: widget.accentColor,
                  onLikeChanged: widget.onLikeChanged,
                ),
              ),

              // 6. Texto descriptivo, nombre de usuario con "Ver más" y badge de sección
              Positioned(
                bottom: 85,
                left: 16,
                right: 90, // Deja espacio para no chocar con los botones laterales
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
                            Flexible(
                              child: Text(
                                widget.sectionTag!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: widget.accentColor ?? Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    _VideoUserAndDescription(
                      userName: effectiveVideo.userName,
                      caption: effectiveVideo.caption,
                      description: effectiveVideo.description,
                      accentColor: widget.accentColor ?? const Color(0xFFFF2A54),
                    ),
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

class _VideoUserAndDescription extends StatefulWidget {
  final String userName;
  final String caption;
  final String description;
  final Color accentColor;

  const _VideoUserAndDescription({
    required this.userName,
    required this.caption,
    required this.description,
    required this.accentColor,
  });

  @override
  State<_VideoUserAndDescription> createState() => _VideoUserAndDescriptionState();
}

class _VideoUserAndDescriptionState extends State<_VideoUserAndDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textToShow = widget.description.isNotEmpty ? widget.description : widget.caption;
    final isLongText = textToShow.length > 55 || textToShow.contains('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Nombre de usuario con badge verificado
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                shadows: [
                  Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1)),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.verified_rounded,
              size: 15,
              color: widget.accentColor,
            ),
          ],
        ),

        const SizedBox(height: 6),

        // Descripción con función "Ver más" / "Ver menos"
        GestureDetector(
          onTap: () {
            if (isLongText) {
              setState(() => isExpanded = !isExpanded);
            }
          },
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState:
                isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  height: 1.35,
                  shadows: [
                    Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1)),
                  ],
                ),
                children: [
                  TextSpan(text: textToShow),
                  if (isLongText)
                    TextSpan(
                      text: ' ( ... más )',
                      style: TextStyle(
                        color: widget.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sección de descripción extensa con desplazamiento vertical
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 110),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      textToShow,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        height: 1.35,
                        shadows: [
                          Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '( ... menos )',
                      style: TextStyle(
                        color: widget.accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 16,
                      color: widget.accentColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

