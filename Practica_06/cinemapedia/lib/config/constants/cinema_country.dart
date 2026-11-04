class CinemaCountry {
  final String name;
  final String code;
  final String language;
  final String languageName;
  final String certification;
  final String adultCertification;

  const CinemaCountry({
    required this.name,
    required this.code,
    required this.language,
    required this.languageName,
    required this.certification,
    required this.adultCertification,
  });
}

const cinemaCountryCatalog = <CinemaCountry>[
  CinemaCountry(
    name: 'México',
    code: 'MX',
    language: 'es-MX',
    languageName: 'Español',
    certification: 'B',
    adultCertification: 'C',
  ),
  CinemaCountry(
    name: 'Estados Unidos',
    code: 'US',
    language: 'en-US',
    languageName: 'English',
    certification: 'PG-13',
    adultCertification: 'R',
  ),
  CinemaCountry(
    name: 'Brasil',
    code: 'BR',
    language: 'pt-BR',
    languageName: 'Português',
    certification: '12',
    adultCertification: '18',
  ),
  CinemaCountry(
    name: 'Alemania',
    code: 'DE',
    language: 'de-DE',
    languageName: 'Deutsch',
    certification: '12',
    adultCertification: '18',
  ),
  CinemaCountry(
    name: 'Egipto',
    code: 'EG',
    language: 'ar-EG',
    languageName: 'العربية',
    certification: '12+',
    adultCertification: '18+',
  ),
  CinemaCountry(
    name: 'Japón',
    code: 'JP',
    language: 'ja-JP',
    languageName: '日本語',
    certification: 'G',
    adultCertification: 'R18+',
  ),
  CinemaCountry(
    name: 'Australia',
    code: 'AU',
    language: 'en-AU',
    languageName: 'English',
    certification: 'PG',
    adultCertification: 'R18+',
  ),
];

final defaultCinemaCountry = cinemaCountryCatalog.first;
