import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/config/constants/country_catalog.dart';
import 'package:cinemapedia/config/helpers/localized_country.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/providers/theme_provider.dart';
import 'package:cinemapedia/presentation/screens/theme_changer/theme_changer_screen.dart';
import 'package:cinemapedia/presentation/screens/series/series_home_screen.dart';
import 'package:cinemapedia/presentation/screens/ranking/demo_ranking_screen.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  final int pageIndex;
  final String? section;

  const HomeScreen({super.key, this.pageIndex = 0, this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _CinemapediaDrawer(
        onNavigate: (section) {
          Navigator.pop(context);
          final sectionParameter = section == null ? '' : '&section=$section';
          context.go('/?page=0$sectionParameter');
        },
        onOpenTheme: () {
          Navigator.pop(context);
          context.pushNamed(ThemeChangerScreen.name);
        },
        onOpenSeries: () {
          Navigator.pop(context);
          context.pushNamed(SeriesHomeScreen.name);
        },
        onOpenRanking: () {
          Navigator.pop(context);
          context.pushNamed(DemoRankingScreen.name);
        },
      ),
      drawerEnableOpenDragGesture: true,
      body: IndexedStack(
        index: pageIndex.clamp(0, 2).toInt(),
        children: [
          HomeView(section: section),
          const CategoriesView(),
          const FavoritesView(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(selectedIndex: pageIndex),
    );
  }
}

class _CinemapediaDrawer extends ConsumerWidget {
  final ValueChanged<String?> onNavigate;
  final VoidCallback onOpenTheme;
  final VoidCallback onOpenSeries;
  final VoidCallback onOpenRanking;

  const _CinemapediaDrawer({
    required this.onNavigate,
    required this.onOpenTheme,
    required this.onOpenSeries,
    required this.onOpenRanking,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: const Color(0xFF171936),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Container(
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF493B91), Color(0xFF17628C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.movie_filter_rounded,
                    size: 42,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12),
                  CinemapediaBrand(foregroundColor: Colors.white),
                  SizedBox(height: 4),
                  Text(
                    l10n.drawerTagline,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const Text(
                    '230362 · BNGG',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _DrawerItem(
              icon: Icons.home_rounded,
              title: l10n.home,
              onTap: () => onNavigate(null),
            ),
            _DrawerItem(
              icon: Icons.local_movies_rounded,
              title: l10n.nowPlaying,
              onTap: () => onNavigate('nowPlaying'),
            ),
            _DrawerItem(
              icon: Icons.trending_up_rounded,
              title: l10n.popular,
              onTap: () => onNavigate('popular'),
            ),
            _DrawerItem(
              icon: Icons.star_rounded,
              title: l10n.topRated,
              onTap: () => onNavigate('topRated'),
            ),
            _DrawerItem(
              icon: Icons.settings_rounded,
              title: l10n.countrySettings,
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF171936),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (context) => const _CinemaCountrySelector(),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.live_tv_outlined,
              title: l10n.series,
              onTap: onOpenSeries,
            ),
            _DrawerItem(
              icon: Icons.leaderboard_outlined,
              title: l10n.rankingTitle,
              onTap: onOpenRanking,
            ),
            ListTile(
              leading: const Icon(
                Icons.palette_outlined,
                color: Color(0xFFB9A6FF),
              ),
              title: Text(
                l10n.themeChangerTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Switch(
                value: ref.watch(themeNotifierProvider).isDarkmode,
                activeThumbColor: const Color(0xFFB9A6FF),
                onChanged: (_) => ref
                    .read(themeNotifierProvider.notifier)
                    .toggleDarkmode(),
              ),
              onTap: onOpenTheme,
              dense: true,
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white12),
            Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                l10n.developedBy,
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ),
            ],
          ),
        ),
      ),
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
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.selectorDescription,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: const ValueKey('interface-language-selector'),
              initialValue: selectedInterfaceLanguage,
              decoration: InputDecoration(
                labelText: l10n.interfaceLanguage,
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF202143),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dropdownColor: const Color(0xFF202143),
              style: const TextStyle(color: Colors.white),
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
                if (language == null) return;
                ref
                    .read(selectedInterfaceLanguageProvider.notifier)
                    .state = language;
              },
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.65,
              ),
              child: ListView(
                shrinkWrap: true,
                children: cinemaCountryCatalog.map((country) {
                  final isSelected = country.code == selectedCountry.code;
                  return ListTile(
                    key: ValueKey('country-${country.code}'),
                    leading: Text(
                      flagForCountry(country.code),
                      style: const TextStyle(fontSize: 26),
                    ),
                    title: Text(
                      localizedCountryName(l10n, country),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      l10n.countryItemDetails(
                        country.code,
                        country.languageName,
                        country.certification,
                      ),
                      style: const TextStyle(color: Colors.white60),
                    ),
                    trailing: isSelected
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
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: const Color(0xFFB9A6FF)),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    onTap: onTap,
    dense: true,
  );
}
