import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/main.dart';

void main() {
  test('Los recursos de imágenes locales están disponibles', () async {
    for (final assetPath in [
      'lib/assets/images/1.png',
      'lib/assets/images/2.png',
      'lib/assets/images/3.png',
      'lib/assets/images/jar-loading.gif',
    ]) {
      expect((await rootBundle.load(assetPath)).lengthInBytes, greaterThan(0));
    }
  });

  testWidgets('Muestra la pantalla principal personalizada', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MainApp()));
    await tester.pumpAndSettle();
    expect(find.text('Widgets App · Práctica 05'), findsOneWidget);
    expect(find.textContaining('Matrícula 230362'), findsOneWidget);
  });
}
