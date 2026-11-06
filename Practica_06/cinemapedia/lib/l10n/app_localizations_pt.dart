// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get discoveryTag => 'DESCUBRA SUA PRÓXIMA HISTÓRIA';

  @override
  String get drawerTagline => 'Seu universo de filmes';

  @override
  String get home => 'Início';

  @override
  String get nowPlaying => 'Em cartaz';

  @override
  String get popular => 'Populares';

  @override
  String get topRated => 'Mais bem avaliados';

  @override
  String get countrySettings => 'País e idioma dos filmes';

  @override
  String get developedBy => 'Desenvolvido por Brisa Nallely Garcia Gregorio';

  @override
  String get comingSoon => 'Em breve';

  @override
  String get now => 'Agora';

  @override
  String get soon => 'Em breve';

  @override
  String get top => 'Top';

  @override
  String get categories => 'Categorias';

  @override
  String get favorites => 'Favoritos';

  @override
  String get selectorDescription =>
      'Altera a região, o idioma do TMDB e a classificação exibida. A interface também muda para o idioma do país selecionado.';

  @override
  String get classification => 'Classificação';

  @override
  String get countryMexico => 'México';

  @override
  String get countryUnitedStates => 'Estados Unidos';

  @override
  String get countryBrazil => 'Brasil';

  @override
  String get countryGermany => 'Alemanha';

  @override
  String get countryEgypt => 'Egito';

  @override
  String get countryJapan => 'Japão';

  @override
  String get countryAustralia => 'Austrália';

  @override
  String get searchMovies => 'Buscar filmes';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get searchFailed => 'Não foi possível realizar a busca.';

  @override
  String get noResults => 'Nenhum filme encontrado.';

  @override
  String get movieLoadFailed => 'Não foi possível carregar o filme.';

  @override
  String get castLoadFailed => 'Não foi possível carregar o elenco.';

  @override
  String get noMoviesFailed => 'Não foi possível carregar os filmes.';

  @override
  String get noMoviesCountry => 'Não há filmes disponíveis para este país.';

  @override
  String get countryRatingTitle => 'Classificação por país';

  @override
  String get atListStart => 'Início da lista · primeiro filme';

  @override
  String get atListEnd => 'Fim da lista · último filme';

  @override
  String get previousMovie => 'Filme anterior';

  @override
  String get nextMovie => 'Próximo filme';

  @override
  String swipeExplore(int current, int total) {
    return 'Deslize para explorar · $current/$total';
  }

  @override
  String get ratingDisclaimer =>
      '* Classificação indicativa. Consulte a classificação oficial local.';

  @override
  String get selectedLanguageTitle => 'Título no idioma selecionado';

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
    return 'Classificação selecionada: $country';
  }

  @override
  String countryItemDetails(String code, String language, String rating) {
    return '$code ($language) · Classificação: $rating';
  }

  @override
  String get openMenu => 'Abrir menu';

  @override
  String get pleaseWait => 'Aguarde';

  @override
  String get loading => 'Carregando...';

  @override
  String get loadingMovies => 'Carregando filmes';

  @override
  String get gettingPopcorn => 'Preparando a pipoca';

  @override
  String get loadingPopular => 'Carregando os populares';

  @override
  String get callingGirlfriend => 'Ligando para minha namorada';

  @override
  String get almostThere => 'Quase lá...';

  @override
  String get takingLonger => 'Está demorando mais do que o esperado :(';

  @override
  String get mainMenu => 'Principal';

  @override
  String get moreOptions => 'Mais opções';

  @override
  String get counterMenuTitle => 'Contador Riverpod';

  @override
  String get counterMenuSubtitle => 'Introdução ao Riverpod';

  @override
  String get buttonsMenuTitle => 'Botões';

  @override
  String get buttonsMenuSubtitle => 'Vários botões no Flutter';

  @override
  String get cardsMenuTitle => 'Cartões';

  @override
  String get cardsMenuSubtitle => 'Um contêiner estilizado';

  @override
  String get progressMenuTitle => 'Indicadores de progresso';

  @override
  String get progressMenuSubtitle => 'Gerais e controlados';

  @override
  String get snackbarsMenuTitle => 'Snackbars e diálogos';

  @override
  String get snackbarsMenuSubtitle => 'Indicadores na tela';

  @override
  String get animatedMenuTitle => 'Contêiner animado';

  @override
  String get animatedMenuSubtitle => 'Widget com estado animado';

  @override
  String get controlsMenuTitle => 'Controles e blocos';

  @override
  String get controlsMenuSubtitle => 'Uma série de controles do Flutter';

  @override
  String get tutorialMenuTitle => 'Introdução ao aplicativo';

  @override
  String get tutorialMenuSubtitle => 'Pequeno tutorial introdutório';

  @override
  String get infiniteMenuTitle => 'Rolagem infinita';

  @override
  String get infiniteMenuSubtitle => 'Listas infinitas e atualizar ao puxar';

  @override
  String get themeMenuTitle => 'Alterar tema';

  @override
  String get themeMenuSubtitle => 'Alterar o tema do aplicativo';

  @override
  String get demoHomeTitle => 'Flutter + Material 3';

  @override
  String get buttonsScreenTitle => 'Tela de botões';

  @override
  String get elevatedButton => 'Elevado';

  @override
  String get disabledElevatedButton => 'Elevado desativado';

  @override
  String get elevatedIconButton => 'Elevado com ícone';

  @override
  String get filledButton => 'Preenchido';

  @override
  String get filledIconButton => 'Preenchido com ícone';

  @override
  String get outlinedButton => 'Contorno';

  @override
  String get outlinedIconButton => 'Contorno com ícone';

  @override
  String get textButton => 'Texto';

  @override
  String get textIconButton => 'Texto com ícone';

  @override
  String get helloWorld => 'Olá, mundo';

  @override
  String get cardsScreenTitle => 'Tela de cartões';

  @override
  String elevation(int level) {
    return 'Elevação $level';
  }

  @override
  String outlinedCard(String label) {
    return '$label - contorno';
  }

  @override
  String filledCard(String label) {
    return '$label - preenchido';
  }

  @override
  String get animatedContainerTitle => 'Contêiner animado';

  @override
  String get tutorialExit => 'Sair';

  @override
  String get tutorialStart => 'Começar';

  @override
  String get tutorialSearchFoodTitle => 'Encontre sua comida';

  @override
  String get tutorialSearchFoodCaption =>
      'Encontre facilmente seus pratos favoritos.';

  @override
  String get tutorialFastDeliveryTitle => 'Entrega rápida';

  @override
  String get tutorialFastDeliveryCaption =>
      'Receba seu pedido onde quer que esteja.';

  @override
  String get tutorialEnjoyFoodTitle => 'Aproveite sua comida';

  @override
  String get tutorialEnjoyFoodCaption =>
      'Aproveite cada pedaço dos seus pratos favoritos.';

  @override
  String get counterScreenTitle => 'Tela do contador';

  @override
  String counterValue(int count) {
    return 'Valor: $count';
  }

  @override
  String get controlsScreenTitle => 'Controles de interface';

  @override
  String get developerMode => 'Modo de desenvolvedor';

  @override
  String get additionalControls => 'Controles adicionais';

  @override
  String get transportationVehicle => 'Meio de transporte';

  @override
  String get byCar => 'De carro';

  @override
  String get travelByCar => 'Viajar de carro';

  @override
  String get byBoat => 'De barco';

  @override
  String get travelByBoat => 'Viajar de barco';

  @override
  String get byPlane => 'De avião';

  @override
  String get travelByPlane => 'Viajar de avião';

  @override
  String get bySubmarine => 'De submarino';

  @override
  String get travelBySubmarine => 'Viajar de submarino';

  @override
  String get breakfast => 'Café da manhã?';

  @override
  String get lunch => 'Almoço?';

  @override
  String get dinner => 'Jantar?';

  @override
  String get progressScreenTitle => 'Indicadores de progresso';

  @override
  String get circularProgress => 'Indicador de progresso circular';

  @override
  String get controlledProgress => 'Indicadores circular e linear controlados';

  @override
  String get snackbarsScreenTitle => 'Snackbars e diálogos';

  @override
  String get ok => 'OK';

  @override
  String get areYouSure => 'Tem certeza?';

  @override
  String get demoDialogMessage =>
      'Esta é uma caixa de confirmação de exemplo. Escolha cancelar ou aceitar para fechá-la.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get accept => 'Aceitar';

  @override
  String get usedLicenses => 'Licenças utilizadas';

  @override
  String get showDialog => 'Mostrar diálogo';

  @override
  String get showSnackbar => 'Mostrar Snackbar';

  @override
  String get demoAboutMessage =>
      'Este aplicativo de exemplo demonstra avisos, diálogos e informações de licenças.';

  @override
  String get themeChangerTitle => 'Alterar tema';

  @override
  String get thisColor => 'Esta cor';
}
