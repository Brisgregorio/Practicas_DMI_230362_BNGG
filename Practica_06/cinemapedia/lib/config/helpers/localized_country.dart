import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

const selectedInterfaceLanguagePreferenceKey = 'selected_interface_language';
const automaticInterfaceLanguage = 'auto';

String loadSelectedInterfaceLanguage(SharedPreferences preferences) {
  final language = preferences.getString(
    selectedInterfaceLanguagePreferenceKey,
  );
  final supportedLanguageCodes = AppLocalizations.supportedLocales
      .map((locale) => locale.languageCode)
      .toSet();
  if (language == automaticInterfaceLanguage ||
      supportedLanguageCodes.contains(language)) {
    return language ?? automaticInterfaceLanguage;
  }
  return automaticInterfaceLanguage;
}

Future<void> saveSelectedInterfaceLanguage(
  SharedPreferences preferences,
  String language,
) async {
  final saved = await preferences.setString(
    selectedInterfaceLanguagePreferenceKey,
    language,
  );
  if (!saved) {
    throw StateError('The selected interface language could not be saved.');
  }
}

Locale interfaceLocaleForCountry(CinemaCountry country) =>
    Locale(country.language.split('-').first);

String localizedCountryName(AppLocalizations l10n, CinemaCountry country) =>
    switch (country.code) {
      'MX' => l10n.countryMexico,
      'US' => l10n.countryUnitedStates,
      'BR' => l10n.countryBrazil,
      'DE' => l10n.countryGermany,
      'EG' => l10n.countryEgypt,
      'JP' => l10n.countryJapan,
      'AU' => l10n.countryAustralia,
      _ => country.name,
    };
