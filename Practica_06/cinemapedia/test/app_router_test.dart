import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/menu/menu_items.dart';
import 'package:cinemapedia/presentation/screens/animated/animated_screen.dart';
import 'package:cinemapedia/presentation/screens/app_tutorial/app_tutorial_screen.dart';
import 'package:cinemapedia/presentation/screens/buttons/buttons_screen.dart';
import 'package:cinemapedia/presentation/screens/cards/cards_screen.dart';
import 'package:cinemapedia/presentation/screens/counter/counter_screen.dart';
import 'package:cinemapedia/presentation/screens/home/home_screen.dart' as demo_home;
import 'package:cinemapedia/presentation/screens/infinite_scroll/infinite_scroll_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/home_screen.dart' as movies_home;
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia/presentation/screens/progress/progress_screen.dart';
import 'package:cinemapedia/presentation/screens/ranking/demo_ranking_screen.dart';
import 'package:cinemapedia/presentation/screens/series/series_detail_screen.dart';
import 'package:cinemapedia/presentation/screens/series/series_home_screen.dart';
import 'package:cinemapedia/presentation/screens/snackbar/snackbar_screen.dart';
import 'package:cinemapedia/presentation/screens/theme_changer/theme_changer_screen.dart';
import 'package:cinemapedia/presentation/screens/ui_controls/ui_controls_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('all demo menu links and Cinemapedia routes resolve uniquely', () {
    final expectedDemoRoutes = <String, String>{
      '/counter-river': CounterScreen.name,
      '/buttons': ButtonsScreen.name,
      '/cards': CardsScreen.name,
      '/progress': ProgressScreen.name,
      '/snackbars': SnackbarScreen.name,
      '/animated': AnimatedScreen.name,
      '/ui-controls': UiControlsScreen.name,
      '/tutorial': AppTutorialScreen.name,
      '/infinite': InfiniteScrollScreen.name,
      '/theme-changer': ThemeChangerScreen.name,
    };

    expect(appMenuItems.map((item) => item.link).toSet(),
        expectedDemoRoutes.keys.toSet());
    for (final entry in expectedDemoRoutes.entries) {
      expect(appRouter.namedLocation(entry.value), entry.key);
    }

    expect(appRouter.namedLocation(demo_home.HomeScreen.name), '/demo-home');
    expect(appRouter.namedLocation(movies_home.HomeScreen.name), '/');
    expect(
      appRouter.namedLocation(
        MovieScreen.name,
        pathParameters: {'id': '42'},
      ),
      '/movie/42',
    );
    expect(appRouter.namedLocation(SeriesHomeScreen.name), '/series');
    expect(
      appRouter.namedLocation(
        SeriesDetailScreen.name,
        pathParameters: {'id': '8'},
      ),
      '/series/8',
    );
    expect(appRouter.namedLocation(DemoRankingScreen.name), '/ranking');
    expect(
      appRouter.namedLocation(
        movies_home.HomeScreen.name,
        queryParameters: {'page': '1'},
      ),
      '/?page=1',
    );
    expect(
      appRouter.namedLocation(
        movies_home.HomeScreen.name,
        queryParameters: {'page': '2'},
      ),
      '/?page=2',
    );
  });
}
