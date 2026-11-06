import 'package:flutter/material.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      elevation: 0,
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
