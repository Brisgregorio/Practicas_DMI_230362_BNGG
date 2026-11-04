import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/config/constants/country_catalog.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _CinemapediaDrawer(),
      drawerEnableOpenDragGesture: true,
      body: const _HomeView(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _CinemapediaDrawer extends StatelessWidget {
  const _CinemapediaDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF171936),
      child: SafeArea(
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
              child: const Column(
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
                    'Tu universo de películas',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '230362 · BNGG',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _DrawerItem(
              icon: Icons.home_rounded,
              title: 'Inicio',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.local_movies_rounded,
              title: 'En cartelera',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.trending_up_rounded,
              title: 'Populares',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.star_rounded,
              title: 'Mejor calificadas',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.settings_rounded,
              title: 'País e idioma de películas',
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
            const Spacer(),
            const Divider(color: Colors.white12),
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Desarrollado por Brisa Nallely Garcia Gregorio',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CinemaCountrySelector extends ConsumerWidget {
  const _CinemaCountrySelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = ref.watch(selectedCinemaCountryProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'País e idioma de películas',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Cambia la región, el idioma de TMDB y la clasificación mostrada. La interfaz permanece en español.',
              style: TextStyle(color: Colors.white70),
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
                    leading: Text(
                      flagForCountry(country.code),
                      style: const TextStyle(fontSize: 26),
                    ),
                    title: Text(
                      country.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${country.code} (${country.languageName}) · Clasificación: ${country.certification}',
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

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  void _reloadHomeMovies() {
    ref.invalidate(nowPlayingMoviesProvider);
    ref.invalidate(popularMoviesProvider);
    ref.invalidate(topRatedMoviesProvider);
    ref.invalidate(upcomingMoviesProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadHomeMovies();
    });
  }

  void _loadHomeMovies() {
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  void initState() {
    super.initState();
    _loadHomeMovies();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedCinemaCountryProvider, (previous, next) {
      _reloadHomeMovies();
    });
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          expandedHeight: 72,
          leading: Builder(
            builder: (context) => IconButton(
              tooltip: 'Abrir menú',
              icon: const Icon(Icons.menu_rounded, size: 28),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          flexibleSpace: const FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 58, bottom: 15),
            title: CustomAppbar(),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFF9E86FF),
                      size: 18,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'DESCUBRE TU PRÓXIMA HISTORIA',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        letterSpacing: 1.3,
                        color: const Color(0xFFB9A6FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MoviesSlideshow(
                key: ValueKey(ref.watch(selectedCinemaCountryProvider).code),
                movies: slideShowMovies,
                isLoading: !ref
                    .watch(nowPlayingMoviesProvider.notifier)
                    .hasLoaded,
                hasError: ref.watch(nowPlayingMoviesProvider.notifier).hasError,
                onRetry: _reloadHomeMovies,
              ),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'En cartelera',
                subTitle: 'Ahora',
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Próximamente',
                subTitle: 'Muy pronto',
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: 'Populares',
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: 'Favoritas del público',
                subTitle: 'Top',
                loadNextPage: () =>
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ],
    );
  }
}
