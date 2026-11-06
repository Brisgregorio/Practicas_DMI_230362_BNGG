import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('pt'),
  ];

  /// No description provided for @discoveryTag.
  ///
  /// In es, this message translates to:
  /// **'DESCUBRE TU PRÓXIMA HISTORIA'**
  String get discoveryTag;

  /// No description provided for @drawerTagline.
  ///
  /// In es, this message translates to:
  /// **'Tu universo de películas'**
  String get drawerTagline;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @nowPlaying.
  ///
  /// In es, this message translates to:
  /// **'En cartelera'**
  String get nowPlaying;

  /// No description provided for @popular.
  ///
  /// In es, this message translates to:
  /// **'Populares'**
  String get popular;

  /// No description provided for @topRated.
  ///
  /// In es, this message translates to:
  /// **'Mejor calificadas'**
  String get topRated;

  /// No description provided for @countrySettings.
  ///
  /// In es, this message translates to:
  /// **'País e idioma de películas'**
  String get countrySettings;

  /// No description provided for @developedBy.
  ///
  /// In es, this message translates to:
  /// **'Desarrollado por Brisa Nallely Garcia Gregorio'**
  String get developedBy;

  /// No description provided for @comingSoon.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get comingSoon;

  /// No description provided for @now.
  ///
  /// In es, this message translates to:
  /// **'Ahora'**
  String get now;

  /// No description provided for @soon.
  ///
  /// In es, this message translates to:
  /// **'Muy pronto'**
  String get soon;

  /// No description provided for @top.
  ///
  /// In es, this message translates to:
  /// **'Top'**
  String get top;

  /// No description provided for @categories.
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get categories;

  /// No description provided for @favorites.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favorites;

  /// No description provided for @selectorDescription.
  ///
  /// In es, this message translates to:
  /// **'Cambia la región, el idioma de TMDB y la clasificación mostrada. La interfaz también cambiará al idioma del país seleccionado.'**
  String get selectorDescription;

  /// No description provided for @classification.
  ///
  /// In es, this message translates to:
  /// **'Clasificación'**
  String get classification;

  /// No description provided for @countryMexico.
  ///
  /// In es, this message translates to:
  /// **'México'**
  String get countryMexico;

  /// No description provided for @countryUnitedStates.
  ///
  /// In es, this message translates to:
  /// **'Estados Unidos'**
  String get countryUnitedStates;

  /// No description provided for @countryBrazil.
  ///
  /// In es, this message translates to:
  /// **'Brasil'**
  String get countryBrazil;

  /// No description provided for @countryGermany.
  ///
  /// In es, this message translates to:
  /// **'Alemania'**
  String get countryGermany;

  /// No description provided for @countryEgypt.
  ///
  /// In es, this message translates to:
  /// **'Egipto'**
  String get countryEgypt;

  /// No description provided for @countryJapan.
  ///
  /// In es, this message translates to:
  /// **'Japón'**
  String get countryJapan;

  /// No description provided for @countryAustralia.
  ///
  /// In es, this message translates to:
  /// **'Australia'**
  String get countryAustralia;

  /// No description provided for @searchMovies.
  ///
  /// In es, this message translates to:
  /// **'Buscar películas'**
  String get searchMovies;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @searchFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo realizar la búsqueda.'**
  String get searchFailed;

  /// No description provided for @noResults.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron películas.'**
  String get noResults;

  /// No description provided for @movieLoadFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar la película.'**
  String get movieLoadFailed;

  /// No description provided for @castLoadFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el reparto.'**
  String get castLoadFailed;

  /// No description provided for @noMoviesFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar las películas.'**
  String get noMoviesFailed;

  /// No description provided for @noMoviesCountry.
  ///
  /// In es, this message translates to:
  /// **'No hay películas disponibles para este país.'**
  String get noMoviesCountry;

  /// No description provided for @countryRatingTitle.
  ///
  /// In es, this message translates to:
  /// **'Clasificación por país'**
  String get countryRatingTitle;

  /// No description provided for @atListStart.
  ///
  /// In es, this message translates to:
  /// **'Inicio de la lista · primera película'**
  String get atListStart;

  /// No description provided for @atListEnd.
  ///
  /// In es, this message translates to:
  /// **'Final de la lista · última película'**
  String get atListEnd;

  /// No description provided for @previousMovie.
  ///
  /// In es, this message translates to:
  /// **'Película anterior'**
  String get previousMovie;

  /// No description provided for @nextMovie.
  ///
  /// In es, this message translates to:
  /// **'Siguiente película'**
  String get nextMovie;

  /// No description provided for @swipeExplore.
  ///
  /// In es, this message translates to:
  /// **'Desliza para explorar · {current}/{total}'**
  String swipeExplore(int current, int total);

  /// No description provided for @ratingDisclaimer.
  ///
  /// In es, this message translates to:
  /// **'* Clasificación orientativa. Consulta la clasificación oficial local.'**
  String get ratingDisclaimer;

  /// No description provided for @selectedLanguageTitle.
  ///
  /// In es, this message translates to:
  /// **'Título en idioma seleccionado'**
  String get selectedLanguageTitle;

  /// No description provided for @originalTitleLanguage.
  ///
  /// In es, this message translates to:
  /// **'Título original ({language})'**
  String originalTitleLanguage(String language);

  /// No description provided for @originalLanguageAndTitle.
  ///
  /// In es, this message translates to:
  /// **'Original ({language}): {title}'**
  String originalLanguageAndTitle(String language, String title);

  /// No description provided for @selectedRatingCountry.
  ///
  /// In es, this message translates to:
  /// **'Clasificación seleccionada: {country}'**
  String selectedRatingCountry(String country);

  /// No description provided for @countryItemDetails.
  ///
  /// In es, this message translates to:
  /// **'{code} ({language}) · Clasificación: {rating}'**
  String countryItemDetails(String code, String language, String rating);

  /// No description provided for @openMenu.
  ///
  /// In es, this message translates to:
  /// **'Abrir menú'**
  String get openMenu;

  /// No description provided for @pleaseWait.
  ///
  /// In es, this message translates to:
  /// **'Espere por favor'**
  String get pleaseWait;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loading;

  /// No description provided for @loadingMovies.
  ///
  /// In es, this message translates to:
  /// **'Cargando películas'**
  String get loadingMovies;

  /// No description provided for @gettingPopcorn.
  ///
  /// In es, this message translates to:
  /// **'Comprando palomitas de maíz'**
  String get gettingPopcorn;

  /// No description provided for @loadingPopular.
  ///
  /// In es, this message translates to:
  /// **'Cargando populares'**
  String get loadingPopular;

  /// No description provided for @callingGirlfriend.
  ///
  /// In es, this message translates to:
  /// **'Llamando a mi novia'**
  String get callingGirlfriend;

  /// No description provided for @almostThere.
  ///
  /// In es, this message translates to:
  /// **'Ya mero...'**
  String get almostThere;

  /// No description provided for @takingLonger.
  ///
  /// In es, this message translates to:
  /// **'Esto está tardando más de lo esperado :('**
  String get takingLonger;

  /// No description provided for @mainMenu.
  ///
  /// In es, this message translates to:
  /// **'Principal'**
  String get mainMenu;

  /// No description provided for @moreOptions.
  ///
  /// In es, this message translates to:
  /// **'Más opciones'**
  String get moreOptions;

  /// No description provided for @counterMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Contador Riverpod'**
  String get counterMenuTitle;

  /// No description provided for @counterMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Introducción a Riverpod'**
  String get counterMenuSubtitle;

  /// No description provided for @buttonsMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Botones'**
  String get buttonsMenuTitle;

  /// No description provided for @buttonsMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Varios botones en Flutter'**
  String get buttonsMenuSubtitle;

  /// No description provided for @cardsMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas'**
  String get cardsMenuTitle;

  /// No description provided for @cardsMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Un contenedor estilizado'**
  String get cardsMenuSubtitle;

  /// No description provided for @progressMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Indicadores de progreso'**
  String get progressMenuTitle;

  /// No description provided for @progressMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Generales y controlados'**
  String get progressMenuSubtitle;

  /// No description provided for @snackbarsMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Snackbars y diálogos'**
  String get snackbarsMenuTitle;

  /// No description provided for @snackbarsMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Indicadores en pantalla'**
  String get snackbarsMenuSubtitle;

  /// No description provided for @animatedMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Contenedor animado'**
  String get animatedMenuTitle;

  /// No description provided for @animatedMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Widget con estado animado'**
  String get animatedMenuSubtitle;

  /// No description provided for @controlsMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Controles e información'**
  String get controlsMenuTitle;

  /// No description provided for @controlsMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Una serie de controles de Flutter'**
  String get controlsMenuSubtitle;

  /// No description provided for @tutorialMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Introducción a la aplicación'**
  String get tutorialMenuTitle;

  /// No description provided for @tutorialMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Pequeño tutorial introductorio'**
  String get tutorialMenuSubtitle;

  /// No description provided for @infiniteMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Desplazamiento infinito'**
  String get infiniteMenuTitle;

  /// No description provided for @infiniteMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Listas infinitas y actualizar al deslizar'**
  String get infiniteMenuSubtitle;

  /// No description provided for @themeMenuTitle.
  ///
  /// In es, this message translates to:
  /// **'Cambiar tema'**
  String get themeMenuTitle;

  /// No description provided for @themeMenuSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Cambiar el tema de la aplicación'**
  String get themeMenuSubtitle;

  /// No description provided for @demoHomeTitle.
  ///
  /// In es, this message translates to:
  /// **'Flutter + Material 3'**
  String get demoHomeTitle;

  /// No description provided for @buttonsScreenTitle.
  ///
  /// In es, this message translates to:
  /// **'Pantalla de botones'**
  String get buttonsScreenTitle;

  /// No description provided for @elevatedButton.
  ///
  /// In es, this message translates to:
  /// **'Elevado'**
  String get elevatedButton;

  /// No description provided for @disabledElevatedButton.
  ///
  /// In es, this message translates to:
  /// **'Elevado deshabilitado'**
  String get disabledElevatedButton;

  /// No description provided for @elevatedIconButton.
  ///
  /// In es, this message translates to:
  /// **'Elevado con icono'**
  String get elevatedIconButton;

  /// No description provided for @filledButton.
  ///
  /// In es, this message translates to:
  /// **'Relleno'**
  String get filledButton;

  /// No description provided for @filledIconButton.
  ///
  /// In es, this message translates to:
  /// **'Relleno con icono'**
  String get filledIconButton;

  /// No description provided for @outlinedButton.
  ///
  /// In es, this message translates to:
  /// **'Contorno'**
  String get outlinedButton;

  /// No description provided for @outlinedIconButton.
  ///
  /// In es, this message translates to:
  /// **'Contorno con icono'**
  String get outlinedIconButton;

  /// No description provided for @textButton.
  ///
  /// In es, this message translates to:
  /// **'Texto'**
  String get textButton;

  /// No description provided for @textIconButton.
  ///
  /// In es, this message translates to:
  /// **'Texto con icono'**
  String get textIconButton;

  /// No description provided for @helloWorld.
  ///
  /// In es, this message translates to:
  /// **'Hola mundo'**
  String get helloWorld;

  /// No description provided for @cardsScreenTitle.
  ///
  /// In es, this message translates to:
  /// **'Pantalla de tarjetas'**
  String get cardsScreenTitle;

  /// No description provided for @elevation.
  ///
  /// In es, this message translates to:
  /// **'Elevación {level}'**
  String elevation(int level);

  /// No description provided for @outlinedCard.
  ///
  /// In es, this message translates to:
  /// **'{label} - contorno'**
  String outlinedCard(String label);

  /// No description provided for @filledCard.
  ///
  /// In es, this message translates to:
  /// **'{label} - rellena'**
  String filledCard(String label);

  /// No description provided for @animatedContainerTitle.
  ///
  /// In es, this message translates to:
  /// **'Contenedor animado'**
  String get animatedContainerTitle;

  /// No description provided for @tutorialExit.
  ///
  /// In es, this message translates to:
  /// **'Salir'**
  String get tutorialExit;

  /// No description provided for @tutorialStart.
  ///
  /// In es, this message translates to:
  /// **'Comenzar'**
  String get tutorialStart;

  /// No description provided for @tutorialSearchFoodTitle.
  ///
  /// In es, this message translates to:
  /// **'Busca la comida'**
  String get tutorialSearchFoodTitle;

  /// No description provided for @tutorialSearchFoodCaption.
  ///
  /// In es, this message translates to:
  /// **'Encuentra fácilmente tus platillos favoritos.'**
  String get tutorialSearchFoodCaption;

  /// No description provided for @tutorialFastDeliveryTitle.
  ///
  /// In es, this message translates to:
  /// **'Entrega rápida'**
  String get tutorialFastDeliveryTitle;

  /// No description provided for @tutorialFastDeliveryCaption.
  ///
  /// In es, this message translates to:
  /// **'Recibe tu pedido dondequiera que estés.'**
  String get tutorialFastDeliveryCaption;

  /// No description provided for @tutorialEnjoyFoodTitle.
  ///
  /// In es, this message translates to:
  /// **'Disfruta la comida'**
  String get tutorialEnjoyFoodTitle;

  /// No description provided for @tutorialEnjoyFoodCaption.
  ///
  /// In es, this message translates to:
  /// **'Disfruta cada bocado de tus platillos favoritos.'**
  String get tutorialEnjoyFoodCaption;

  /// No description provided for @counterScreenTitle.
  ///
  /// In es, this message translates to:
  /// **'Pantalla de contador'**
  String get counterScreenTitle;

  /// No description provided for @counterValue.
  ///
  /// In es, this message translates to:
  /// **'Valor: {count}'**
  String counterValue(int count);

  /// No description provided for @controlsScreenTitle.
  ///
  /// In es, this message translates to:
  /// **'Controles de interfaz'**
  String get controlsScreenTitle;

  /// No description provided for @developerMode.
  ///
  /// In es, this message translates to:
  /// **'Modo de desarrollador'**
  String get developerMode;

  /// No description provided for @additionalControls.
  ///
  /// In es, this message translates to:
  /// **'Controles adicionales'**
  String get additionalControls;

  /// No description provided for @transportationVehicle.
  ///
  /// In es, this message translates to:
  /// **'Vehículo de transporte'**
  String get transportationVehicle;

  /// No description provided for @byCar.
  ///
  /// In es, this message translates to:
  /// **'En automóvil'**
  String get byCar;

  /// No description provided for @travelByCar.
  ///
  /// In es, this message translates to:
  /// **'Viajar en automóvil'**
  String get travelByCar;

  /// No description provided for @byBoat.
  ///
  /// In es, this message translates to:
  /// **'En barco'**
  String get byBoat;

  /// No description provided for @travelByBoat.
  ///
  /// In es, this message translates to:
  /// **'Viajar en barco'**
  String get travelByBoat;

  /// No description provided for @byPlane.
  ///
  /// In es, this message translates to:
  /// **'En avión'**
  String get byPlane;

  /// No description provided for @travelByPlane.
  ///
  /// In es, this message translates to:
  /// **'Viajar en avión'**
  String get travelByPlane;

  /// No description provided for @bySubmarine.
  ///
  /// In es, this message translates to:
  /// **'En submarino'**
  String get bySubmarine;

  /// No description provided for @travelBySubmarine.
  ///
  /// In es, this message translates to:
  /// **'Viajar en submarino'**
  String get travelBySubmarine;

  /// No description provided for @breakfast.
  ///
  /// In es, this message translates to:
  /// **'¿Desayuno?'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In es, this message translates to:
  /// **'¿Almuerzo?'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In es, this message translates to:
  /// **'¿Cena?'**
  String get dinner;

  /// No description provided for @progressScreenTitle.
  ///
  /// In es, this message translates to:
  /// **'Indicadores de progreso'**
  String get progressScreenTitle;

  /// No description provided for @circularProgress.
  ///
  /// In es, this message translates to:
  /// **'Indicador de progreso circular'**
  String get circularProgress;

  /// No description provided for @controlledProgress.
  ///
  /// In es, this message translates to:
  /// **'Indicadores circular y lineal controlados'**
  String get controlledProgress;

  /// No description provided for @snackbarsScreenTitle.
  ///
  /// In es, this message translates to:
  /// **'Snackbars y diálogos'**
  String get snackbarsScreenTitle;

  /// No description provided for @ok.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get ok;

  /// No description provided for @areYouSure.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro?'**
  String get areYouSure;

  /// No description provided for @demoDialogMessage.
  ///
  /// In es, this message translates to:
  /// **'Esta es una ventana de confirmación de ejemplo. Puedes cancelar o aceptar para cerrarla.'**
  String get demoDialogMessage;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @accept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get accept;

  /// No description provided for @usedLicenses.
  ///
  /// In es, this message translates to:
  /// **'Licencias utilizadas'**
  String get usedLicenses;

  /// No description provided for @showDialog.
  ///
  /// In es, this message translates to:
  /// **'Mostrar diálogo'**
  String get showDialog;

  /// No description provided for @showSnackbar.
  ///
  /// In es, this message translates to:
  /// **'Mostrar Snackbar'**
  String get showSnackbar;

  /// No description provided for @demoAboutMessage.
  ///
  /// In es, this message translates to:
  /// **'Esta aplicación de ejemplo muestra cómo se presentan los avisos, diálogos y la información de licencias.'**
  String get demoAboutMessage;

  /// No description provided for @themeChangerTitle.
  ///
  /// In es, this message translates to:
  /// **'Cambiar tema'**
  String get themeChangerTitle;

  /// No description provided for @thisColor.
  ///
  /// In es, this message translates to:
  /// **'Este color'**
  String get thisColor;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'ja',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
