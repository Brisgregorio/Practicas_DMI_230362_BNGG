import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  final String? section;

  const HomeView({super.key, this.section});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  final _scrollController = ScrollController();
  final _nowPlayingKey = GlobalKey();
  final _popularKey = GlobalKey();
  final _topRatedKey = GlobalKey();
  String? _pendingSection;

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
    _pendingSection = widget.section;
    _loadHomeMovies();
  }

  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.section != widget.section) {
      _pendingSection = widget.section;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToPendingSection() {
    final sectionKey = switch (_pendingSection) {
      'nowPlaying' => _nowPlayingKey,
      'popular' => _popularKey,
      'topRated' => _topRatedKey,
      _ => null,
    };
    if (sectionKey == null) return;

    _pendingSection = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetContext = sectionKey.currentContext;
      if (!mounted || targetContext == null) return;
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
    _scrollToPendingSection();

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          expandedHeight: 72,
          leading: Builder(
            builder: (context) => IconButton(
              tooltip: l10n.openMenu,
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
                      l10n.discoveryTag,
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
                key: _nowPlayingKey,
                movies: nowPlayingMovies,
                title: l10n.nowPlaying,
                subTitle: l10n.now,
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: l10n.comingSoon,
                subTitle: l10n.soon,
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                key: _popularKey,
                movies: popularMovies,
                title: l10n.popular,
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                key: _topRatedKey,
                movies: topRatedMovies,
                title: l10n.topRated,
                subTitle: l10n.top,
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