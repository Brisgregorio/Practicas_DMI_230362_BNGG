import 'package:cinemapedia/config/helpers/localized_country.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const interfaceLanguageOptions = <String, String>{
  'es': 'Español',
  'en': 'English',
  'pt': 'Português',
  'de': 'Deutsch',
  'ar': 'العربية',
  'ja': '日本語',
  'zh': '中文',
};

final selectedInterfaceLanguageProvider = StateProvider<String>(
  (ref) => automaticInterfaceLanguage,
);

final interfaceLocaleProvider = Provider<Locale>((ref) {
  final selectedLanguage = ref.watch(selectedInterfaceLanguageProvider);
  if (selectedLanguage == automaticInterfaceLanguage) {
    return interfaceLocaleForCountry(ref.watch(selectedCinemaCountryProvider));
  }
  return Locale(selectedLanguage);
});
