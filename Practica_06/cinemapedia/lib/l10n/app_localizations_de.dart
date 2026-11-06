// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get discoveryTag => 'ENTDECKE DEINE NÄCHSTE GESCHICHTE';

  @override
  String get drawerTagline => 'Dein Filmuniversum';

  @override
  String get home => 'Startseite';

  @override
  String get nowPlaying => 'Im Kino';

  @override
  String get popular => 'Beliebt';

  @override
  String get topRated => 'Am besten bewertet';

  @override
  String get countrySettings => 'Filmland und Sprache';

  @override
  String get developedBy => 'Entwickelt von Brisa Nallely Garcia Gregorio';

  @override
  String get comingSoon => 'Demnächst';

  @override
  String get now => 'Jetzt';

  @override
  String get soon => 'Bald';

  @override
  String get top => 'Top';

  @override
  String get categories => 'Kategorien';

  @override
  String get favorites => 'Favoriten';

  @override
  String get selectorDescription =>
      'Ändert die Region, die TMDB-Sprache und die angezeigte Altersfreigabe. Die Benutzeroberfläche wechselt ebenfalls zur Sprache des ausgewählten Landes.';

  @override
  String get classification => 'Altersfreigabe';

  @override
  String get countryMexico => 'Mexiko';

  @override
  String get countryUnitedStates => 'Vereinigte Staaten';

  @override
  String get countryBrazil => 'Brasilien';

  @override
  String get countryGermany => 'Deutschland';

  @override
  String get countryEgypt => 'Ägypten';

  @override
  String get countryJapan => 'Japan';

  @override
  String get countryAustralia => 'Australien';

  @override
  String get searchMovies => 'Filme suchen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get searchFailed => 'Die Suche konnte nicht ausgeführt werden.';

  @override
  String get noResults => 'Keine Filme gefunden.';

  @override
  String get movieLoadFailed => 'Der Film konnte nicht geladen werden.';

  @override
  String get castLoadFailed => 'Die Besetzung konnte nicht geladen werden.';

  @override
  String get noMoviesFailed => 'Die Filme konnten nicht geladen werden.';

  @override
  String get noMoviesCountry => 'Für dieses Land sind keine Filme verfügbar.';

  @override
  String get countryRatingTitle => 'Altersfreigabe nach Land';

  @override
  String get atListStart => 'Listenanfang · erster Film';

  @override
  String get atListEnd => 'Listenende · letzter Film';

  @override
  String get previousMovie => 'Vorheriger Film';

  @override
  String get nextMovie => 'Nächster Film';

  @override
  String swipeExplore(int current, int total) {
    return 'Wischen zum Entdecken · $current/$total';
  }

  @override
  String get ratingDisclaimer =>
      '* Richtwert. Bitte die offizielle lokale Altersfreigabe prüfen.';

  @override
  String get selectedLanguageTitle => 'Titel in der ausgewählten Sprache';

  @override
  String originalTitleLanguage(String language) {
    return 'Originaltitel ($language)';
  }

  @override
  String originalLanguageAndTitle(String language, String title) {
    return 'Original ($language): $title';
  }

  @override
  String selectedRatingCountry(String country) {
    return 'Ausgewählte Altersfreigabe: $country';
  }

  @override
  String countryItemDetails(String code, String language, String rating) {
    return '$code ($language) · Altersfreigabe: $rating';
  }

  @override
  String get openMenu => 'Menü öffnen';

  @override
  String get pleaseWait => 'Bitte warten';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get loadingMovies => 'Filme werden geladen';

  @override
  String get gettingPopcorn => 'Popcorn wird vorbereitet';

  @override
  String get loadingPopular => 'Beliebte Filme werden geladen';

  @override
  String get callingGirlfriend => 'Ich rufe meine Freundin an';

  @override
  String get almostThere => 'Fast geschafft...';

  @override
  String get takingLonger => 'Das dauert länger als erwartet :(';

  @override
  String get mainMenu => 'Hauptmenü';

  @override
  String get moreOptions => 'Weitere Optionen';

  @override
  String get counterMenuTitle => 'Riverpod-Zähler';

  @override
  String get counterMenuSubtitle => 'Einführung in Riverpod';

  @override
  String get buttonsMenuTitle => 'Schaltflächen';

  @override
  String get buttonsMenuSubtitle => 'Verschiedene Flutter-Schaltflächen';

  @override
  String get cardsMenuTitle => 'Karten';

  @override
  String get cardsMenuSubtitle => 'Ein gestalteter Container';

  @override
  String get progressMenuTitle => 'Fortschrittsanzeigen';

  @override
  String get progressMenuSubtitle => 'Allgemein und gesteuert';

  @override
  String get snackbarsMenuTitle => 'Snackbars und Dialoge';

  @override
  String get snackbarsMenuSubtitle => 'Bildschirmanzeigen';

  @override
  String get animatedMenuTitle => 'Animierter Container';

  @override
  String get animatedMenuSubtitle => 'Animiertes Stateful-Widget';

  @override
  String get controlsMenuTitle => 'UI-Steuerelemente';

  @override
  String get controlsMenuSubtitle =>
      'Eine Sammlung von Flutter-Steuerelementen';

  @override
  String get tutorialMenuTitle => 'App-Einführung';

  @override
  String get tutorialMenuSubtitle => 'Kurzes Einführungstutorial';

  @override
  String get infiniteMenuTitle => 'Endloses Scrollen';

  @override
  String get infiniteMenuSubtitle =>
      'Endloslisten und Aktualisieren durch Ziehen';

  @override
  String get themeMenuTitle => 'Design ändern';

  @override
  String get themeMenuSubtitle => 'App-Design ändern';

  @override
  String get demoHomeTitle => 'Flutter + Material 3';

  @override
  String get buttonsScreenTitle => 'Schaltflächen';

  @override
  String get elevatedButton => 'Erhöht';

  @override
  String get disabledElevatedButton => 'Erhöht, deaktiviert';

  @override
  String get elevatedIconButton => 'Erhöht mit Symbol';

  @override
  String get filledButton => 'Ausgefüllt';

  @override
  String get filledIconButton => 'Ausgefüllt mit Symbol';

  @override
  String get outlinedButton => 'Umrandet';

  @override
  String get outlinedIconButton => 'Umrandet mit Symbol';

  @override
  String get textButton => 'Text';

  @override
  String get textIconButton => 'Text mit Symbol';

  @override
  String get helloWorld => 'Hallo Welt';

  @override
  String get cardsScreenTitle => 'Karten';

  @override
  String elevation(int level) {
    return 'Höhe $level';
  }

  @override
  String outlinedCard(String label) {
    return '$label - umrandet';
  }

  @override
  String filledCard(String label) {
    return '$label - ausgefüllt';
  }

  @override
  String get animatedContainerTitle => 'Animierter Container';

  @override
  String get tutorialExit => 'Beenden';

  @override
  String get tutorialStart => 'Los geht\'s';

  @override
  String get tutorialSearchFoodTitle => 'Finde dein Essen';

  @override
  String get tutorialSearchFoodCaption =>
      'Finde ganz einfach deine Lieblingsgerichte.';

  @override
  String get tutorialFastDeliveryTitle => 'Schnelle Lieferung';

  @override
  String get tutorialFastDeliveryCaption =>
      'Erhalte deine Bestellung, wo immer du bist.';

  @override
  String get tutorialEnjoyFoodTitle => 'Genieße dein Essen';

  @override
  String get tutorialEnjoyFoodCaption =>
      'Genieße jeden Bissen deiner Lieblingsgerichte.';

  @override
  String get counterScreenTitle => 'Zähler';

  @override
  String counterValue(int count) {
    return 'Wert: $count';
  }

  @override
  String get controlsScreenTitle => 'UI-Steuerelemente';

  @override
  String get developerMode => 'Entwicklermodus';

  @override
  String get additionalControls => 'Zusätzliche Steuerelemente';

  @override
  String get transportationVehicle => 'Verkehrsmittel';

  @override
  String get byCar => 'Mit dem Auto';

  @override
  String get travelByCar => 'Mit dem Auto reisen';

  @override
  String get byBoat => 'Mit dem Boot';

  @override
  String get travelByBoat => 'Mit dem Boot reisen';

  @override
  String get byPlane => 'Mit dem Flugzeug';

  @override
  String get travelByPlane => 'Mit dem Flugzeug reisen';

  @override
  String get bySubmarine => 'Mit dem U-Boot';

  @override
  String get travelBySubmarine => 'Mit dem U-Boot reisen';

  @override
  String get breakfast => 'Frühstück?';

  @override
  String get lunch => 'Mittagessen?';

  @override
  String get dinner => 'Abendessen?';

  @override
  String get progressScreenTitle => 'Fortschrittsanzeigen';

  @override
  String get circularProgress => 'Kreisförmige Fortschrittsanzeige';

  @override
  String get controlledProgress => 'Gesteuerte Kreis- und lineare Anzeigen';

  @override
  String get snackbarsScreenTitle => 'Snackbars und Dialoge';

  @override
  String get ok => 'OK';

  @override
  String get areYouSure => 'Bist du sicher?';

  @override
  String get demoDialogMessage =>
      'Dies ist ein Beispieldialog zur Bestätigung. Wähle Abbrechen oder Bestätigen, um ihn zu schließen.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get accept => 'Bestätigen';

  @override
  String get usedLicenses => 'Verwendete Lizenzen';

  @override
  String get showDialog => 'Dialog anzeigen';

  @override
  String get showSnackbar => 'Snackbar anzeigen';

  @override
  String get demoAboutMessage =>
      'Diese Beispiel-App zeigt Hinweise, Dialoge und Lizenzinformationen.';

  @override
  String get themeChangerTitle => 'Design ändern';

  @override
  String get thisColor => 'Diese Farbe';
}
