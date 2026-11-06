import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/config/helpers/localized_country.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('selected country resolves to the corresponding interface language', () {
    final expectedLocales = <String, String>{
      'MX': 'es',
      'US': 'en',
      'BR': 'pt',
      'DE': 'de',
      'EG': 'ar',
      'JP': 'ja',
      'AU': 'en',
    };

    for (final country in cinemaCountryCatalog) {
      expect(
        interfaceLocaleForCountry(country).languageCode,
        expectedLocales[country.code],
      );
    }
  });

  test('saved country is restored from its single persisted code', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final germany = cinemaCountryCatalog.singleWhere(
      (country) => country.code == 'DE',
    );
    await saveSelectedCinemaCountry(preferences, germany);

    expect(loadSelectedCinemaCountry(preferences).code, 'DE');
  });

  testWidgets('all supported locales load and Arabic uses RTL', (tester) async {
    const expectedTranslations = <String, String>{
      'es': 'País e idioma de películas',
      'en': 'Movie country and language',
      'pt': 'País e idioma dos filmes',
      'de': 'Filmland und Sprache',
      'ar': 'بلد الأفلام ولغتها',
      'ja': '映画の国と言語',
    };

    for (final entry in expectedTranslations.entries) {
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(entry.key),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Builder(
            builder: (context) => Text(
              AppLocalizations.of(context)!.countrySettings,
              textDirection: Directionality.of(context),
            ),
          ),
        ),
      );

      expect(find.text(entry.value), findsOneWidget);
      expect(
        tester.widget<Text>(find.byType(Text)).textDirection,
        entry.key == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      );
    }
  });
}
