import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('country selector contains the required countries by continent', () {
    expect(cinemaCountryCatalog.map((country) => country.code).toList(), [
      'MX',
      'US',
      'BR',
      'DE',
      'EG',
      'JP',
      'AU',
    ]);
  });

  test('country selection carries the movie language and classification', () {
    final germany = cinemaCountryCatalog.singleWhere(
      (country) => country.code == 'DE',
    );

    expect(germany.language, 'de-DE');
    expect(germany.certification, '12');
    expect(germany.adultCertification, '18');
  });
}
