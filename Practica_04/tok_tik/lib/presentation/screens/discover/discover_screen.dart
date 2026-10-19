import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/season_config.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/favorites/favorites_view.dart';
import 'package:toktik/presentation/widgets/shared/seasonal_bottom_navigation.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatefulWidget {
  final AppSeason season;

  const DiscoverScreen({super.key, this.season = AppSeason.normal});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late AppSeason _currentSeason;
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentSeason = widget.season;
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showSeasonSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Temporada de TokTik',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'La temporada se detecta automáticamente por la fecha del dispositivo, pero también puedes probar cualquiera manualmente:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white60),
                ),
                const SizedBox(height: 16),
                ...AppSeason.values.map((season) {
                  final isSelected = season == _currentSeason;
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        season.logoAsset,
                        width: 38,
                        height: 38,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      season.displayName,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? season.accentColor : Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      season.welcomeGreeting,
                      style: const TextStyle(fontSize: 12, color: Colors.white54),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: season.accentColor)
                        : null,
                    onTap: () async {
                      setState(() => _currentSeason = season);
                      await SeasonConfig.syncAppIcon(season);
                      if (ctx.mounted) Navigator.pop(ctx);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: season.accentColor,
                            content: Text(
                              'Temporada: ${season.displayName}. El icono se actualizará en tu pantalla de inicio al salir.',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Contenido principal: PageView horizontal entre las 4 secciones
          discoverProvider.initialLoading
              ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
              : PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: [
                    // Sección 1: Para ti
                    VideoScrollableView(
                      videos: discoverProvider.forYouVideos,
                      sectionTag: '✨ Para ti',
                      accentColor: _currentSeason.accentColor,
                      isActive: _currentIndex == 0,
                    ),

                    // Sección 2: Cerca de ti
                    VideoScrollableView(
                      videos: discoverProvider.nearYouVideos,
                      sectionTag: '📍 Cerca de ti • En tu zona',
                      accentColor: _currentSeason.accentColor,
                      isActive: _currentIndex == 1,
                    ),

                    // Sección 3: Descubrir
                    VideoScrollableView(
                      videos: discoverProvider.discoverVideos,
                      sectionTag: '🔥 Descubrir • Tendencias',
                      accentColor: _currentSeason.accentColor,
                      isActive: _currentIndex == 2,
                    ),

                    // Sección 4: Favoritos (Sección creada sin funcionalidad aún)
                    FavoritesView(
                      season: _currentSeason,
                      onExplorePressed: () => _onTabTapped(0),
                    ),
                  ],
                ),

          // 2. Encabezado superior con botón de temporada y pestaña activa
          Positioned(
            top: 48,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón de temporada interactivo
                GestureDetector(
                  onTap: () => _showSeasonSelector(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _currentSeason.accentColor.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            _currentSeason.logoAsset,
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _currentSeason.displayName,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _currentSeason.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Indicador de sección actual
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    _getSectionName(_currentIndex),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Menú de navegación inferior entre secciones (adaptado a festividades)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SeasonalBottomNavigation(
              currentIndex: _currentIndex,
              season: _currentSeason,
              onTap: _onTabTapped,
            ),
          ),
        ],
      ),
    );
  }

  String _getSectionName(int index) {
    switch (index) {
      case 0:
        return 'Para ti';
      case 1:
        return 'Cerca de ti';
      case 2:
        return 'Descubrir';
      case 3:
        return 'Favoritos';
      default:
        return 'TokTik';
    }
  }
}
