import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/screens/animated/animated_screen.dart';
import 'package:cinemapedia/presentation/screens/app_tutorial/app_tutorial_screen.dart';
import 'package:cinemapedia/presentation/screens/buttons/buttons_screen.dart';
import 'package:cinemapedia/presentation/screens/cards/cards_screen.dart';
import 'package:cinemapedia/presentation/screens/counter/counter_screen.dart';
import 'package:cinemapedia/presentation/screens/home/home_screen.dart' as demo_home;
import 'package:cinemapedia/presentation/screens/infinite_scroll/infinite_scroll_screen.dart';
import 'package:cinemapedia/presentation/screens/progress/progress_screen.dart';
import 'package:cinemapedia/presentation/screens/snackbar/snackbar_screen.dart';
import 'package:cinemapedia/presentation/screens/ui_controls/ui_controls_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.tryParse(state.uri.queryParameters['page'] ?? '0');
        return HomeScreen(
          pageIndex: pageIndex ?? 0,
          section: state.uri.queryParameters['section'],
        );
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/theme-changer',
      name: ThemeChangerScreen.name,
      builder: (context, state) => const ThemeChangerScreen(),
    ),
    GoRoute(
      path: '/series',
      name: SeriesHomeScreen.name,
      builder: (context, state) => const SeriesHomeScreen(),
      routes: [
        GoRoute(
          path: ':id',
          name: SeriesDetailScreen.name,
          builder: (context, state) => SeriesDetailScreen(
            seriesId: state.pathParameters['id'] ?? 'no-id',
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/ranking',
      name: DemoRankingScreen.name,
      builder: (context, state) => const DemoRankingScreen(),
    ),
    GoRoute(
      path: '/demo-home',
      name: demo_home.HomeScreen.name,
      builder: (context, state) => const demo_home.HomeScreen(),
    ),
    GoRoute(
      path: '/counter-river',
      name: CounterScreen.name,
      builder: (context, state) => const CounterScreen(),
    ),
    GoRoute(
      path: '/buttons',
      name: ButtonsScreen.name,
      builder: (context, state) => const ButtonsScreen(),
    ),
    GoRoute(
      path: '/cards',
      name: CardsScreen.name,
      builder: (context, state) => const CardsScreen(),
    ),
    GoRoute(
      path: '/progress',
      name: ProgressScreen.name,
      builder: (context, state) => const ProgressScreen(),
    ),
    GoRoute(
      path: '/snackbars',
      name: SnackbarScreen.name,
      builder: (context, state) => const SnackbarScreen(),
    ),
    GoRoute(
      path: '/animated',
      name: AnimatedScreen.name,
      builder: (context, state) => const AnimatedScreen(),
    ),
    GoRoute(
      path: '/ui-controls',
      name: UiControlsScreen.name,
      builder: (context, state) => const UiControlsScreen(),
    ),
    GoRoute(
      path: '/tutorial',
      name: AppTutorialScreen.name,
      builder: (context, state) => const AppTutorialScreen(),
    ),
    GoRoute(
      path: '/infinite',
      name: InfiniteScrollScreen.name,
      builder: (context, state) => const InfiniteScrollScreen(),
    ),
  ],
);
