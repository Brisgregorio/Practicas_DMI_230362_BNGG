// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get discoveryTag => 'DESCUBRE TU PRÓXIMA HISTORIA';

  @override
  String get drawerTagline => 'Tu universo de películas';

  @override
  String get home => 'Inicio';

  @override
  String get nowPlaying => 'En cartelera';

  @override
  String get popular => 'Populares';

  @override
  String get topRated => 'Mejor calificadas';

  @override
  String get countrySettings => 'País e idioma de películas';

  @override
  String get developedBy => 'Desarrollado por Brisa Nallely Garcia Gregorio';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get now => 'Ahora';

  @override
  String get soon => 'Muy pronto';

  @override
  String get top => 'Top';

  @override
  String get categories => 'Categorías';

  @override
  String get favorites => 'Favoritos';

  @override
  String get selectorDescription =>
      'Cambia la región, el idioma de TMDB y la clasificación mostrada. La interfaz también cambiará al idioma del país seleccionado.';

  @override
  String get classification => 'Clasificación';

  @override
  String get countryMexico => 'México';

  @override
  String get countryUnitedStates => 'Estados Unidos';

  @override
  String get countryBrazil => 'Brasil';

  @override
  String get countryGermany => 'Alemania';

  @override
  String get countryEgypt => 'Egipto';

  @override
  String get countryJapan => 'Japón';

  @override
  String get countryAustralia => 'Australia';

  @override
  String get searchMovies => 'Buscar películas';

  @override
  String get retry => 'Reintentar';

  @override
  String get searchFailed => 'No se pudo realizar la búsqueda.';

  @override
  String get noResults => 'No se encontraron películas.';

  @override
  String get movieLoadFailed => 'No se pudo cargar la película.';

  @override
  String get castLoadFailed => 'No se pudo cargar el reparto.';

  @override
  String get noMoviesFailed => 'No se pudieron cargar las películas.';

  @override
  String get noMoviesCountry => 'No hay películas disponibles para este país.';

  @override
  String get countryRatingTitle => 'Clasificación por país';

  @override
  String get atListStart => 'Inicio de la lista · primera película';

  @override
  String get atListEnd => 'Final de la lista · última película';

  @override
  String get previousMovie => 'Película anterior';

  @override
  String get nextMovie => 'Siguiente película';

  @override
  String swipeExplore(int current, int total) {
    return 'Desliza para explorar · $current/$total';
  }

  @override
  String get ratingDisclaimer =>
      '* Clasificación orientativa. Consulta la clasificación oficial local.';

  @override
  String get selectedLanguageTitle => 'Título en idioma seleccionado';

  @override
  String originalTitleLanguage(String language) {
    return 'Título original ($language)';
  }

  @override
  String originalLanguageAndTitle(String language, String title) {
    return 'Original ($language): $title';
  }

  @override
  String selectedRatingCountry(String country) {
    return 'Clasificación seleccionada: $country';
  }

  @override
  String countryItemDetails(String code, String language, String rating) {
    return '$code ($language) · Clasificación: $rating';
  }

  @override
  String get openMenu => 'Abrir menú';

  @override
  String get pleaseWait => 'Espere por favor';

  @override
  String get loading => 'Cargando...';

  @override
  String get loadingMovies => 'Cargando películas';

  @override
  String get gettingPopcorn => 'Comprando palomitas de maíz';

  @override
  String get loadingPopular => 'Cargando populares';

  @override
  String get callingGirlfriend => 'Llamando a mi novia';

  @override
  String get almostThere => 'Ya mero...';

  @override
  String get takingLonger => 'Esto está tardando más de lo esperado :(';

  @override
  String get mainMenu => 'Principal';

  @override
  String get moreOptions => 'Más opciones';

  @override
  String get counterMenuTitle => 'Contador Riverpod';

  @override
  String get counterMenuSubtitle => 'Introducción a Riverpod';

  @override
  String get buttonsMenuTitle => 'Botones';

  @override
  String get buttonsMenuSubtitle => 'Varios botones en Flutter';

  @override
  String get cardsMenuTitle => 'Tarjetas';

  @override
  String get cardsMenuSubtitle => 'Un contenedor estilizado';

  @override
  String get progressMenuTitle => 'Indicadores de progreso';

  @override
  String get progressMenuSubtitle => 'Generales y controlados';

  @override
  String get snackbarsMenuTitle => 'Snackbars y diálogos';

  @override
  String get snackbarsMenuSubtitle => 'Indicadores en pantalla';

  @override
  String get animatedMenuTitle => 'Contenedor animado';

  @override
  String get animatedMenuSubtitle => 'Widget con estado animado';

  @override
  String get controlsMenuTitle => 'Controles e información';

  @override
  String get controlsMenuSubtitle => 'Una serie de controles de Flutter';

  @override
  String get tutorialMenuTitle => 'Introducción a la aplicación';

  @override
  String get tutorialMenuSubtitle => 'Pequeño tutorial introductorio';

  @override
  String get infiniteMenuTitle => 'Desplazamiento infinito';

  @override
  String get infiniteMenuSubtitle =>
      'Listas infinitas y actualizar al deslizar';

  @override
  String get themeMenuTitle => 'Cambiar tema';

  @override
  String get themeMenuSubtitle => 'Cambiar el tema de la aplicación';

  @override
  String get demoHomeTitle => 'Flutter + Material 3';

  @override
  String get buttonsScreenTitle => 'Pantalla de botones';

  @override
  String get elevatedButton => 'Elevado';

  @override
  String get disabledElevatedButton => 'Elevado deshabilitado';

  @override
  String get elevatedIconButton => 'Elevado con icono';

  @override
  String get filledButton => 'Relleno';

  @override
  String get filledIconButton => 'Relleno con icono';

  @override
  String get outlinedButton => 'Contorno';

  @override
  String get outlinedIconButton => 'Contorno con icono';

  @override
  String get textButton => 'Texto';

  @override
  String get textIconButton => 'Texto con icono';

  @override
  String get helloWorld => 'Hola mundo';

  @override
  String get cardsScreenTitle => 'Pantalla de tarjetas';

  @override
  String elevation(int level) {
    return 'Elevación $level';
  }

  @override
  String outlinedCard(String label) {
    return '$label - contorno';
  }

  @override
  String filledCard(String label) {
    return '$label - rellena';
  }

  @override
  String get animatedContainerTitle => 'Contenedor animado';

  @override
  String get tutorialExit => 'Salir';

  @override
  String get tutorialStart => 'Comenzar';

  @override
  String get tutorialSearchFoodTitle => 'Busca la comida';

  @override
  String get tutorialSearchFoodCaption =>
      'Encuentra fácilmente tus platillos favoritos.';

  @override
  String get tutorialFastDeliveryTitle => 'Entrega rápida';

  @override
  String get tutorialFastDeliveryCaption =>
      'Recibe tu pedido dondequiera que estés.';

  @override
  String get tutorialEnjoyFoodTitle => 'Disfruta la comida';

  @override
  String get tutorialEnjoyFoodCaption =>
      'Disfruta cada bocado de tus platillos favoritos.';

  @override
  String get counterScreenTitle => 'Pantalla de contador';

  @override
  String counterValue(int count) {
    return 'Valor: $count';
  }

  @override
  String get controlsScreenTitle => 'Controles de interfaz';

  @override
  String get developerMode => 'Modo de desarrollador';

  @override
  String get additionalControls => 'Controles adicionales';

  @override
  String get transportationVehicle => 'Vehículo de transporte';

  @override
  String get byCar => 'En automóvil';

  @override
  String get travelByCar => 'Viajar en automóvil';

  @override
  String get byBoat => 'En barco';

  @override
  String get travelByBoat => 'Viajar en barco';

  @override
  String get byPlane => 'En avión';

  @override
  String get travelByPlane => 'Viajar en avión';

  @override
  String get bySubmarine => 'En submarino';

  @override
  String get travelBySubmarine => 'Viajar en submarino';

  @override
  String get breakfast => '¿Desayuno?';

  @override
  String get lunch => '¿Almuerzo?';

  @override
  String get dinner => '¿Cena?';

  @override
  String get progressScreenTitle => 'Indicadores de progreso';

  @override
  String get circularProgress => 'Indicador de progreso circular';

  @override
  String get controlledProgress => 'Indicadores circular y lineal controlados';

  @override
  String get snackbarsScreenTitle => 'Snackbars y diálogos';

  @override
  String get ok => 'Aceptar';

  @override
  String get areYouSure => '¿Estás seguro?';

  @override
  String get demoDialogMessage =>
      'Esta es una ventana de confirmación de ejemplo. Puedes cancelar o aceptar para cerrarla.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get accept => 'Aceptar';

  @override
  String get usedLicenses => 'Licencias utilizadas';

  @override
  String get showDialog => 'Mostrar diálogo';

  @override
  String get showSnackbar => 'Mostrar Snackbar';

  @override
  String get demoAboutMessage =>
      'Esta aplicación de ejemplo muestra cómo se presentan los avisos, diálogos y la información de licencias.';

  @override
  String get themeChangerTitle => 'Cambiar tema';

  @override
  String get thisColor => 'Este color';
}
