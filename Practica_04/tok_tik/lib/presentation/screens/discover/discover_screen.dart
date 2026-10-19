import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/season_config.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatefulWidget {
  final AppSeason season;

  const DiscoverScreen({super.key, this.season = AppSeason.normal});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late AppSeason _currentSeason;

  @override
  void initState() {
    super.initState();
    _currentSeason = widget.season;
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
      body: Stack(
        children: [
          discoverProvider.initialLoading
              ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
              : VideoScrollableView(videos: discoverProvider.videos),

          // Botón superior de temporada actual
          Positioned(
            top: 48,
            left: 16,
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }
}
