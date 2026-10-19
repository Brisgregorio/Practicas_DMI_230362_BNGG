import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toktik/config/theme/season_config.dart';

class SeasonalBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final AppSeason season;
  final ValueChanged<int> onTap;

  const SeasonalBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.season,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _NavItemData(
        label: 'Para ti',
        icon: Icons.play_circle_outline_rounded,
        activeIcon: Icons.play_circle_filled_rounded,
      ),
      _NavItemData(
        label: 'Cerca de ti',
        icon: Icons.location_on_outlined,
        activeIcon: Icons.location_on_rounded,
      ),
      _NavItemData(
        label: 'Descubrir',
        icon: Icons.explore_outlined,
        activeIcon: Icons.explore_rounded,
      ),
      _NavItemData(
        label: 'Favoritos',
        icon: Icons.favorite_outline_rounded,
        activeIcon: Icons.favorite_rounded,
      ),
    ];

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.82),
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 0.8,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 58,
              child: Row(
                children: List.generate(navItems.length, (index) {
                  final item = navItems[index];
                  final isSelected = index == currentIndex;

                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onTap(index),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedScale(
                            scale: isSelected ? 1.12 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutBack,
                            child: Icon(
                              isSelected ? item.activeIcon : item.icon,
                              size: 24,
                              color: isSelected ? season.accentColor : Colors.white60,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? season.accentColor : Colors.white60,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          // Indicador animado de temporada
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: isSelected ? 18 : 0,
                            height: 2.5,
                            decoration: BoxDecoration(
                              color: season.accentColor,
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: season.accentColor.withValues(alpha: 0.6),
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  _NavItemData({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}
