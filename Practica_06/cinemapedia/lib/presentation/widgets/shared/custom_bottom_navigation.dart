import 'package:flutter/material.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigation({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: selectedIndex.clamp(0, 2).toInt(),
      onTap: (index) => context.go('/?page=$index'),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_max),
          label: l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.label_outline),
          label: l10n.categories,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline),
          label: l10n.favorites,
        ),
      ],
    );
  }
}
