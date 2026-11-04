import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCinemaCountryProvider = StateProvider<CinemaCountry>(
  (ref) => defaultCinemaCountry,
);
