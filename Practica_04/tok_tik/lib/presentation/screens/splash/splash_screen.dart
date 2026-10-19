import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:toktik/config/theme/season_config.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

class SplashScreen extends StatefulWidget {
  final AppSeason season;

  const SplashScreen({
    super.key,
    required this.season,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _startSplashSequence();
  }

  Future<void> _startSplashSequence() async {
    // Sincronizar el icono nativo de la app en Android
    SeasonConfig.syncAppIcon(widget.season);

    // Reproducir el sonido de bienvenida correspondiente a la temporada
    try {
      await _audioPlayer.play(AssetSource(widget.season.audioSourcePath));
    } catch (e) {
      debugPrint('No se pudo reproducir el sonido de bienvenida: $e');
    }

    // Esperar unos segundos para mostrar el logo y sonido antes de ir al feed
    await Future.delayed(const Duration(milliseconds: 2800));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => DiscoverScreen(season: widget.season),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final season = widget.season;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fondo degradado sutil con el color temático
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.1),
                radius: 1.1,
                colors: [
                  season.accentColor.withValues(alpha: 0.28),
                  Colors.black,
                ],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo animado con zoom y rebote elegante
                ElasticIn(
                  duration: const Duration(milliseconds: 1200),
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: season.accentColor.withValues(alpha: 0.45),
                          blurRadius: 36,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        season.logoAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.play_circle_fill,
                          size: 110,
                          color: season.accentColor,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Título de la app
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 300),
                  child: const Text(
                    'TokTik',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Mensaje de bienvenida de la temporada
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: season.accentColor.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: season.accentColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      season.welcomeGreeting,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: season.accentColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Indicador sutil de carga
                FadeIn(
                  delay: const Duration(milliseconds: 900),
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(season.accentColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
