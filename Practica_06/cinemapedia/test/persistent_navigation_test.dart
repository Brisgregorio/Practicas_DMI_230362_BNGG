import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/screens/navigation/cinemapedia_navigation_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('wide layout keeps the rail visible and preserves branch state', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = _router();
    await tester.pumpWidget(_app(router));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsOneWidget);
    await tester.tap(find.text('Increment'));
    await tester.pumpAndSettle();
    expect(find.text('Count: 1'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationRail),
        matching: find.text('Series'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Current: Series'), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(tester.widget<NavigationRail>(find.byType(NavigationRail)).selectedIndex, 7);

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationRail),
        matching: find.text('Home'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Count: 1'), findsOneWidget);

    for (final section in [
      'Movies',
      'Now playing',
      'Popular',
      'Top rated',
      'Categories',
      'Favorites',
    ]) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationRail),
          matching: find.text(section),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Current: $section'), findsOneWidget);
      final selectedIndex = switch (section) {
        'Movies' => 1,
        'Now playing' => 2,
        'Popular' => 3,
        'Top rated' => 4,
        'Categories' => 5,
        _ => 6,
      };
      expect(
        tester.widget<NavigationRail>(find.byType(NavigationRail)).selectedIndex,
        selectedIndex,
      );
    }
  });

  testWidgets('mobile layout opens and closes the drawer when navigating', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_app(_router()));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsNothing);
    await tester.tap(find.text('Increment'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Open menu'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationDrawer), findsOneWidget);

    await tester.tap(find.text('Series').last);
    await tester.pumpAndSettle();
    expect(find.text('Current: Series'), findsOneWidget);
    expect(find.byType(NavigationDrawer), findsNothing);

    await tester.tap(find.byTooltip('Open menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home').last);
    await tester.pumpAndSettle();
    expect(find.text('Count: 1'), findsOneWidget);
    expect(find.byType(NavigationDrawer), findsNothing);
  });
}

Widget _app(GoRouter router) => ProviderScope(
  child: MaterialApp.router(
    routerConfig: router,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
  ),
);

GoRouter _router() => GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          CinemapediaNavigationShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) {
                final page = state.uri.queryParameters['page'];
                final section = state.uri.queryParameters['section'];
                final title = switch (page) {
                  '1' => 'Categories',
                  '2' => 'Favorites',
                  _ => switch (section) {
                    'movies' => 'Movies',
                    'nowPlaying' => 'Now playing',
                    'popular' => 'Popular',
                    'topRated' => 'Top rated',
                    _ => 'Home',
                  },
                };
                return _TestSection(title: title, showCounter: true);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/series',
              builder: (context, state) => const _TestSection(title: 'Series'),
            ),
          ],
        ),
      ],
    ),
  ],
);

class _TestSection extends StatefulWidget {
  final String title;
  final bool showCounter;

  const _TestSection({required this.title, this.showCounter = false});

  @override
  State<_TestSection> createState() => _TestSectionState();
}

class _TestSectionState extends State<_TestSection> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            tooltip: 'Open menu',
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ),
        title: Text(widget.title),
      ),
      Text('Current: ${widget.title}'),
      if (widget.showCounter) ...[
        Text('Count: $_count'),
        TextButton(
          onPressed: () => setState(() => _count++),
          child: const Text('Increment'),
        ),
      ],
    ],
  );
}
