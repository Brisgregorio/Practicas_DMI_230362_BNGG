import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const selectedCinemaCountryPreferenceKey = 'selected_cinema_country_code';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw StateError(
    'SharedPreferences must be initialized before app startup.',
  ),
);

final selectedCinemaCountryProvider = StateProvider<CinemaCountry>(
  (ref) => defaultCinemaCountry,
);

CinemaCountry cinemaCountryFromCode(String? code) {
  for (final country in cinemaCountryCatalog) {
    if (country.code == code) return country;
  }
  return defaultCinemaCountry;
}

CinemaCountry loadSelectedCinemaCountry(SharedPreferences preferences) =>
    cinemaCountryFromCode(
      preferences.getString(selectedCinemaCountryPreferenceKey),
    );

Future<void> saveSelectedCinemaCountry(
  SharedPreferences preferences,
  CinemaCountry country,
) async {
  final saved = await preferences.setString(
    selectedCinemaCountryPreferenceKey,
    country.code,
  );
  if (!saved) {
    throw StateError('The selected country could not be saved.');
  }
}
