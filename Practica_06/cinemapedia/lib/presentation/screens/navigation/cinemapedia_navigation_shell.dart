import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/config/constants/country_catalog.dart';
import 'package:cinemapedia/config/helpers/localized_country.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:cinemapedia/presentation/providers/settings/interface_language_provider.dart';
import 'package:cinemapedia/presentation/providers/theme_provider.dart';
import 'package:cinemapedia/presentation/screens/ranking/demo_ranking_screen.dart';
import 'package:cinemapedia/presentation/screens/theme_changer/theme_changer_screen.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CinemapediaNavigationShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const CinemapediaNavigationShell({super.key, required this.navigationShell});

  // A compact rail fits alongside the content on most tablets. Below this
  // width the drawer preserves the space needed by the active screen.
  static const double _railBreakpoint = 760;
  static const double _extendedBreakpoint = 1180;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isWide = width >= _railBreakpoint;
        final selectedIndex = _selectedDestination(
          GoRouterState.of(context).uri,
        );

        return Scaffold(
          drawer: isWide
              ? null
              : _CinemapediaDrawer(
                  selectedIndex: selectedIndex,
                  onSelect: (index) => _selectDestination(context, index),
                ),
          body: Row(
            children: [
              if (isWide)
                _CinemapediaRail(
                  selectedIndex: selectedIndex,
                  extended: width >= _extendedBreakpoint,
                  onSelect: (index) => _selectDestination(context, index),
                  onOpenSettings: () => _showCountrySettings(context),
                  onOpenTheme: () => context.pushNamed(ThemeChangerScreen.name),
                  onOpenRanking: () =>
                      context.pushNamed(DemoRankingScreen.name),
                ),
              Expanded(child: navigationShell),
            ],
          ),
          bottomNavigationBar: !isWide && navigationShell.currentIndex == 0
              ? CustomBottomNavigation(
                  selectedIndex:
                      int.tryParse(
                        GoRouterState.of(context).uri.queryParameters['page'] ??
                            '0',
                      ) ??
                      0,
                )
              : null,
        );
      },
    );
  }

  void _selectDestination(BuildContext context, int index) {
    if (index == 7) {
      navigationShell.goBranch(1);
      return;
    }

    final location = switch (index) {
      1 => '/?page=0&section=movies',
      2 => '/?page=0&section=nowPlaying',
      3 => '/?page=0&section=popular',
      4 => '/?page=0&section=topRated',
      5 => '/?page=1',
      6 => '/?page=2',
      _ => '/?page=0',
    };
    GoRouter.of(context).go(location);
  }

  int _selectedDestination(Uri uri) {
    if (uri.path.startsWith('/series')) return 7;
    final page = int.tryParse(uri.queryParameters['page'] ?? '0') ?? 0;
    if (page == 1) return 5;
    if (page == 2) return 6;
    return switch (uri.queryParameters['section']) {
      'movies' => 1,
      'nowPlaying' => 2,
      'popular' => 3,
      'topRated' => 4,
      _ => 0,
    };
  }

  void _showCountrySettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF171936),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const _CinemaCountrySelector(),
    );
  }
}

class _CinemapediaRail extends StatelessWidget {
  final int selectedIndex;
  final bool extended;
  final ValueChanged<int> onSelect;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenTheme;
  final VoidCallback onOpenRanking;

  const _CinemapediaRail({
    required this.selectedIndex,
    required this.extended,
    required this.onSelect,
    required this.onOpenSettings,
    required this.onOpenTheme,
    required this.onOpenRanking,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final destinations = _destinations(l10n);

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFF171936)),
      child: NavigationRail(
        backgroundColor: const Color(0xFF171936),
        scrollable: true,
        selectedIndex: selectedIndex,
        extended: extended,
        labelType: extended ? null : NavigationRailLabelType.all,
        onDestinationSelected: onSelect,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CinemapediaBrand(
            compact: !extended,
            foregroundColor: Colors.white,
          ),
        ),
        destinations: [
          for (final destination in destinations)
            NavigationRailDestination(
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: Text(destination.label),
            ),
        ],
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: l10n.countrySettings,
              onPressed: onOpenSettings,
              icon: const Icon(Icons.settings_rounded),
            ),
            IconButton(
              tooltip: l10n.themeChangerTitle,
              onPressed: onOpenTheme,
              icon: const Icon(Icons.palette_outlined),
            ),
            IconButton(
              tooltip: l10n.rankingTitle,
              onPressed: onOpenRanking,
              icon: const Icon(Icons.leaderboard_outlined),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _CinemapediaDrawer extends ConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _CinemapediaDrawer({
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final destinations = _destinations(l10n);

    return NavigationDrawer(
      backgroundColor: const Color(0xFF171936),
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        Navigator.pop(context);
        onSelect(index);
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.movie_filter_rounded,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(height: 12),
              const CinemapediaBrand(foregroundColor: Colors.white),
              const SizedBox(height: 4),
              Text(
                l10n.drawerTagline,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        for (final destination in destinations)
          NavigationDrawerDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: Text(destination.label),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Divider(color: Colors.white24),
        ),
        ListTile(
          leading: const Icon(Icons.settings_rounded, color: Color(0xFFB9A6FF)),
          title: Text(l10n.countrySettings),
          onTap: () {
            Navigator.pop(context);
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xFF171936),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (context) => const _CinemaCountrySelector(),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.palette_outlined, color: Color(0xFFB9A6FF)),
          title: Text(l10n.themeChangerTitle),
          trailing: Switch(
            value: ref.watch(themeNotifierProvider).isDarkmode,
            onChanged: (_) =>
                ref.read(themeNotifierProvider.notifier).toggleDarkmode(),
          ),
          onTap: () {
            Navigator.pop(context);
            context.pushNamed(ThemeChangerScreen.name);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.leaderboard_outlined,
            color: Color(0xFFB9A6FF),
          ),
          title: Text(l10n.rankingTitle),
          onTap: () {
            Navigator.pop(context);
            context.pushNamed(DemoRankingScreen.name);
          },
        ),
      ],
    );
  }
}

class _CinemaCountrySelector extends ConsumerWidget {
  const _CinemaCountrySelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedCountry = ref.watch(selectedCinemaCountryProvider);
    final selectedInterfaceLanguage = ref.watch(
      selectedInterfaceLanguageProvider,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.countrySettings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(l10n.selectorDescription),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: const ValueKey('interface-language-selector'),
              initialValue: selectedInterfaceLanguage,
              decoration: InputDecoration(labelText: l10n.interfaceLanguage),
              items: [
                DropdownMenuItem(
                  value: automaticInterfaceLanguage,
                  child: Text(l10n.followCountryLanguage),
                ),
                ...interfaceLanguageOptions.entries.map(
                  (language) => DropdownMenuItem(
                    value: language.key,
                    child: Text(language.value),
                  ),
                ),
              ],
              onChanged: (language) {
                if (language != null) {
                  ref.read(selectedInterfaceLanguageProvider.notifier).state =
                      language;
                }
              },
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.55,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final country in cinemaCountryCatalog)
                    ListTile(
                      leading: Text(
                        flagForCountry(country.code),
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(localizedCountryName(l10n, country)),
                      subtitle: Text(
                        l10n.countryItemDetails(
                          country.code,
                          country.languageName,
                          country.certification,
                        ),
                      ),
                      trailing: country.code == selectedCountry.code
                          ? const Icon(
                              Icons.check_circle,
                              color: Color(0xFFB9A6FF),
                            )
                          : null,
                      onTap: () {
                        ref.read(selectedCinemaCountryProvider.notifier).state =
                            country;
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<_NavigationDestination> _destinations(AppLocalizations l10n) => [
  _NavigationDestination(Icons.home_outlined, Icons.home_rounded, l10n.home),
  _NavigationDestination(Icons.movie_outlined, Icons.movie, l10n.movies),
  _NavigationDestination(
    Icons.local_movies_outlined,
    Icons.local_movies_rounded,
    l10n.nowPlaying,
  ),
  _NavigationDestination(
    Icons.trending_up_outlined,
    Icons.trending_up_rounded,
    l10n.popular,
  ),
  _NavigationDestination(
    Icons.star_border_rounded,
    Icons.star_rounded,
    l10n.topRated,
  ),
  _NavigationDestination(
    Icons.label_outline,
    Icons.label_rounded,
    l10n.categories,
  ),
  _NavigationDestination(Icons.favorite_border, Icons.favorite, l10n.favorites),
  _NavigationDestination(Icons.live_tv_outlined, Icons.live_tv, l10n.series),
];

class _NavigationDestination {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavigationDestination(this.icon, this.selectedIcon, this.label);
}
