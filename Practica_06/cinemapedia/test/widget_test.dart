// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('changing the locale updates the visible interface', (
    tester,
  ) async {
    Widget localizedApp(Locale locale) => MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Builder(
        builder: (context) => Text(AppLocalizations.of(context)!.home),
      ),
    );

    await tester.pumpWidget(localizedApp(const Locale('es')));
    expect(find.text('Inicio'), findsOneWidget);

    await tester.pumpWidget(localizedApp(const Locale('en')));
    expect(find.text('Home'), findsOneWidget);
  });
}
