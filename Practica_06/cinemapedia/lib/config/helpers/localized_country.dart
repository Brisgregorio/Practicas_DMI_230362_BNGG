import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

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
