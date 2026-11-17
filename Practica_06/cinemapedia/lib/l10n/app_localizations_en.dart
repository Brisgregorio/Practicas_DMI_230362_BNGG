// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get discoveryTag => 'DISCOVER YOUR NEXT STORY';

  @override
  String get drawerTagline => 'Your movie universe';

  @override
  String get home => 'Home';

  @override
  String get nowPlaying => 'Now playing';

  @override
  String get popular => 'Popular';

  @override
  String get topRated => 'Top rated';

  @override
  String get countrySettings => 'Movie country and language';

  @override
  String get developedBy => 'Developed by Brisa Nallely Garcia Gregorio';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get now => 'Now';

  @override
  String get soon => 'Coming soon';

  @override
  String get top => 'Top';

  @override
  String get categories => 'Categories';

  @override
  String get favorites => 'Favorites';

  @override
  String get addToFavorites => 'Add to favorites';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get noFavoriteMovies => 'You have no favorite movies yet.';

  @override
  String get favoritesLoadFailed => 'Favorite movies could not be loaded.';

  @override
  String get selectGenre => 'Choose a genre to see its movies.';

  @override
  String get genresLoadFailed => 'Genres could not be loaded.';

  @override
  String get genreMoviesLoadFailed =>
      'Movies in this genre could not be loaded.';

  @override
  String get noMoviesForGenre => 'No movies are available in this genre.';

  @override
  String get series => 'Series';

  @override
  String get popularSeries => 'Popular series';

  @override
  String get seriesLoadFailed => 'Popular series could not be loaded.';

  @override
  String get seriesDetailsLoadFailed => 'Series details could not be loaded.';

  @override
  String get tvSeriesOverviewUnavailable => 'No description is available.';

  @override
  String tvSeriesVotes(int count) {
    return '$count votes';
  }

  @override
  String get tvSeriesGenres => 'Genres';

  @override
  String get tvSeriesFirstAirDate => 'First aired';

  @override
  String get tvSeriesLastAirDate => 'Last aired';

  @override
  String get tvSeriesStatus => 'Status';

  @override
  String get tvSeriesSeasons => 'Seasons';

  @override
  String get tvSeriesEpisodes => 'Episodes';

  @override
  String get tvSeriesCreators => 'Created by';

  @override
  String get tvSeriesProductionCompanies => 'Production companies';

  @override
  String get tvSeriesNetworks => 'Networks';

  @override
  String get noPopularSeries => 'No popular series are available.';

  @override
  String get noFavorites => 'You have no favorites yet.';

  @override
  String get rankingTitle => 'Ranking';

  @override
  String get demoDataLabel => 'Demonstration data';

  @override
  String get demoDataDescription =>
      'Profiles and points are fictional examples, not real users or scores.';

  @override
  String demoProfile(int number) {
    return 'Example profile $number';
  }

  @override
  String demoPoints(int points) {
    return '$points points';
  }

  @override
  String get selectorDescription =>
      'The country controls TMDB region, language, and rating. The interface language can be selected independently.';

  @override
  String get interfaceLanguage => 'Interface language';

  @override
  String get followCountryLanguage => 'Follow country language';

  @override
  String get classification => 'Rating';

  @override
  String get countryMexico => 'Mexico';

  @override
  String get countryUnitedStates => 'United States';

  @override
  String get countryBrazil => 'Brazil';

  @override
  String get countryGermany => 'Germany';

  @override
  String get countryEgypt => 'Egypt';

  @override
  String get countryJapan => 'Japan';

  @override
  String get countryAustralia => 'Australia';

  @override
  String get searchMovies => 'Search movies';

  @override
  String get searchTvSeries => 'Search TV series';

  @override
  String get searchTvSeriesHint => 'Enter a series name to search.';

  @override
  String get noTvSeriesResults => 'No TV series were found.';

  @override
  String get tvSeriesSearchFailed => 'TV series search failed.';

  @override
  String get clearTvSeriesSearch => 'Clear search';

  @override
  String get retry => 'Retry';

  @override
  String get searchFailed => 'The search could not be completed.';

  @override
  String get noResults => 'No movies were found.';

  @override
  String get movieLoadFailed => 'The movie could not be loaded.';

  @override
  String get castLoadFailed => 'The cast could not be loaded.';

  @override
  String get castTitle => 'Cast';

  @override
  String get castEmpty => 'No cast information is available.';

  @override
  String get noMoviesFailed => 'Movies could not be loaded.';

  @override
  String get noMoviesCountry => 'No movies are available for this country.';

  @override
  String get countryRatingTitle => 'Country rating';

  @override
  String get atListStart => 'Start of the list · first movie';

  @override
  String get atListEnd => 'End of the list · last movie';

  @override
  String get previousMovie => 'Previous movie';

  @override
  String get nextMovie => 'Next movie';

  @override
  String swipeExplore(int current, int total) {
    return 'Swipe to explore · $current/$total';
  }

  @override
  String get ratingDisclaimer =>
      '* Indicative rating. Check your local official rating.';

  @override
  String get selectedLanguageTitle => 'Title in selected language';

  @override
  String originalTitleLanguage(String language) {
    return 'Original title ($language)';
  }

  @override
  String originalLanguageAndTitle(String language, String title) {
    return 'Original ($language): $title';
  }

  @override
  String selectedRatingCountry(String country) {
    return 'Selected rating: $country';
  }

  @override
  String countryItemDetails(String code, String language, String rating) {
    return '$code ($language) · Rating: $rating';
  }

  @override
  String get openMenu => 'Open menu';

  @override
  String get pleaseWait => 'Get comfy, the show is about to start!';

  @override
  String get loading => 'Looking for the remote...';

  @override
  String get loadingMovies => 'Convincing the movies to show up...';

  @override
  String get gettingPopcorn => 'Negotiating with the popcorn...';

  @override
  String get loadingPopular => 'Calling the stars...';

  @override
  String get callingGirlfriend => 'Asking the director to hold the slate...';

  @override
  String get almostThere => 'The trailer is almost here!';

  @override
  String get takingLonger => 'The movie is taking its sweet time to arrive...';

  @override
  String get mainMenu => 'Main';

  @override
  String get moreOptions => 'More options';

  @override
  String get counterMenuTitle => 'Riverpod Counter';

  @override
  String get counterMenuSubtitle => 'Introduction to Riverpod';

  @override
  String get buttonsMenuTitle => 'Buttons';

  @override
  String get buttonsMenuSubtitle => 'Various buttons in Flutter';

  @override
  String get cardsMenuTitle => 'Cards';

  @override
  String get cardsMenuSubtitle => 'A styled container';

  @override
  String get progressMenuTitle => 'Progress indicators';

  @override
  String get progressMenuSubtitle => 'Basic and controlled';

  @override
  String get snackbarsMenuTitle => 'Snackbars and dialogs';

  @override
  String get snackbarsMenuSubtitle => 'On-screen indicators';

  @override
  String get animatedMenuTitle => 'Animated container';

  @override
  String get animatedMenuSubtitle => 'Animated stateful widget';

  @override
  String get controlsMenuTitle => 'UI controls and tiles';

  @override
  String get controlsMenuSubtitle => 'A collection of Flutter controls';

  @override
  String get tutorialMenuTitle => 'App introduction';

  @override
  String get tutorialMenuSubtitle => 'A short introductory tutorial';

  @override
  String get infiniteMenuTitle => 'Infinite scrolling';

  @override
  String get infiniteMenuSubtitle => 'Infinite lists and pull to refresh';

  @override
  String get themeMenuTitle => 'Change theme';

  @override
  String get themeMenuSubtitle => 'Change the app theme';

  @override
  String get demoHomeTitle => 'Flutter + Material 3';

  @override
  String get buttonsScreenTitle => 'Buttons screen';

  @override
  String get elevatedButton => 'Elevated';

  @override
  String get disabledElevatedButton => 'Disabled elevated';

  @override
  String get elevatedIconButton => 'Elevated with icon';

  @override
  String get filledButton => 'Filled';

  @override
  String get filledIconButton => 'Filled with icon';

  @override
  String get outlinedButton => 'Outlined';

  @override
  String get outlinedIconButton => 'Outlined with icon';

  @override
  String get textButton => 'Text';

  @override
  String get textIconButton => 'Text with icon';

  @override
  String get helloWorld => 'Hello world';

  @override
  String get cardsScreenTitle => 'Cards screen';

  @override
  String elevation(int level) {
    return 'Elevation $level';
  }

  @override
  String outlinedCard(String label) {
    return '$label - outlined';
  }

  @override
  String filledCard(String label) {
    return '$label - filled';
  }

  @override
  String get animatedContainerTitle => 'Animated container';

  @override
  String get tutorialExit => 'Exit';

  @override
  String get tutorialStart => 'Get started';

  @override
  String get tutorialSearchFoodTitle => 'Find your food';

  @override
  String get tutorialSearchFoodCaption => 'Easily find your favorite dishes.';

  @override
  String get tutorialFastDeliveryTitle => 'Fast delivery';

  @override
  String get tutorialFastDeliveryCaption => 'Get your order wherever you are.';

  @override
  String get tutorialEnjoyFoodTitle => 'Enjoy your food';

  @override
  String get tutorialEnjoyFoodCaption =>
      'Enjoy every bite of your favorite dishes.';

  @override
  String get counterScreenTitle => 'Counter screen';

  @override
  String counterValue(int count) {
    return 'Value: $count';
  }

  @override
  String get controlsScreenTitle => 'UI controls';

  @override
  String get developerMode => 'Developer mode';

  @override
  String get additionalControls => 'Additional controls';

  @override
  String get transportationVehicle => 'Means of transport';

  @override
  String get byCar => 'By car';

  @override
  String get travelByCar => 'Travel by car';

  @override
  String get byBoat => 'By boat';

  @override
  String get travelByBoat => 'Travel by boat';

  @override
  String get byPlane => 'By plane';

  @override
  String get travelByPlane => 'Travel by plane';

  @override
  String get bySubmarine => 'By submarine';

  @override
  String get travelBySubmarine => 'Travel by submarine';

  @override
  String get breakfast => 'Breakfast?';

  @override
  String get lunch => 'Lunch?';

  @override
  String get dinner => 'Dinner?';

  @override
  String get progressScreenTitle => 'Progress indicators';

  @override
  String get circularProgress => 'Circular progress indicator';

  @override
  String get controlledProgress => 'Controlled circular and linear indicators';

  @override
  String get snackbarsScreenTitle => 'Snackbars and dialogs';

  @override
  String get ok => 'OK';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get demoDialogMessage =>
      'This is a sample confirmation dialog. Choose cancel or accept to close it.';

  @override
  String get cancel => 'Cancel';

  @override
  String get accept => 'Accept';

  @override
  String get usedLicenses => 'Used licenses';

  @override
  String get showDialog => 'Show dialog';

  @override
  String get showSnackbar => 'Show snackbar';

  @override
  String get demoAboutMessage =>
      'This sample app demonstrates notifications, dialogs, and license information.';

  @override
  String get themeChangerTitle => 'Change theme';

  @override
  String get thisColor => 'This color';

  @override
  String get tvSeriesGenreResultsLoadFailed =>
      'TV series in this genre could not be loaded.';

  @override
  String get all => 'All';

  @override
  String get noTvSeriesForGenre => 'No series are available in this genre.';

  @override
  String get tvSeriesGenresLoadFailed =>
      'TV series genres could not be loaded.';

  @override
  String get movies => 'Movies';
}
