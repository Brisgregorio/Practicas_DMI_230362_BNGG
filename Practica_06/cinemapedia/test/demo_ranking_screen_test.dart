import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/screens/ranking/demo_ranking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ranking labels its profiles and scores as fictional demo data', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const DemoRankingScreen(),
      ),
    );

    expect(find.text('Datos de demostración'), findsOneWidget);
    expect(
      find.textContaining('no representan usuarios ni puntuaciones reales'),
      findsOneWidget,
    );
    expect(find.text('Perfil de ejemplo 1'), findsOneWidget);
    expect(find.text('120 puntos'), findsOneWidget);
  });
}
