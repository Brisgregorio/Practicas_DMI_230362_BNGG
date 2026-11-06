// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get discoveryTag => '次のお気に入りの物語を見つけよう';

  @override
  String get drawerTagline => '映画の世界へようこそ';

  @override
  String get home => 'ホーム';

  @override
  String get nowPlaying => '上映中';

  @override
  String get popular => '人気作品';

  @override
  String get topRated => '高評価';

  @override
  String get countrySettings => '映画の国と言語';

  @override
  String get developedBy => '開発者: Brisa Nallely Garcia Gregorio';

  @override
  String get comingSoon => '近日公開';

  @override
  String get now => '現在';

  @override
  String get soon => '近日';

  @override
  String get top => 'トップ';

  @override
  String get categories => 'カテゴリ';

  @override
  String get favorites => 'お気に入り';

  @override
  String get selectorDescription =>
      '地域、TMDBの言語、表示されるレーティングを変更します。画面の言語も選択した国の言語に切り替わります。';

  @override
  String get classification => 'レーティング';

  @override
  String get countryMexico => 'メキシコ';

  @override
  String get countryUnitedStates => 'アメリカ合衆国';

  @override
  String get countryBrazil => 'ブラジル';

  @override
  String get countryGermany => 'ドイツ';

  @override
  String get countryEgypt => 'エジプト';

  @override
  String get countryJapan => '日本';

  @override
  String get countryAustralia => 'オーストラリア';

  @override
  String get searchMovies => '映画を検索';

  @override
  String get retry => '再試行';

  @override
  String get searchFailed => '検索を完了できませんでした。';

  @override
  String get noResults => '映画が見つかりませんでした。';

  @override
  String get movieLoadFailed => '映画を読み込めませんでした。';

  @override
  String get castLoadFailed => 'キャストを読み込めませんでした。';

  @override
  String get noMoviesFailed => '映画を読み込めませんでした。';

  @override
  String get noMoviesCountry => 'この国で利用できる映画はありません。';

  @override
  String get countryRatingTitle => '国別レーティング';

  @override
  String get atListStart => 'リストの先頭 · 最初の映画';

  @override
  String get atListEnd => 'リストの末尾 · 最後の映画';

  @override
  String get previousMovie => '前の映画';

  @override
  String get nextMovie => '次の映画';

  @override
  String swipeExplore(int current, int total) {
    return 'スワイプして探索 · $current/$total';
  }

  @override
  String get ratingDisclaimer => '* 目安のレーティングです。現地の公式レーティングをご確認ください。';

  @override
  String get selectedLanguageTitle => '選択した言語のタイトル';

  @override
  String originalTitleLanguage(String language) {
    return '原題 ($language)';
  }

  @override
  String originalLanguageAndTitle(String language, String title) {
    return '原題 ($language): $title';
  }

  @override
  String selectedRatingCountry(String country) {
    return '選択したレーティング: $country';
  }

  @override
  String countryItemDetails(String code, String language, String rating) {
    return '$code ($language) · レーティング: $rating';
  }

  @override
  String get openMenu => 'メニューを開く';

  @override
  String get pleaseWait => 'お待ちください';

  @override
  String get loading => '読み込み中...';

  @override
  String get loadingMovies => '映画を読み込み中';

  @override
  String get gettingPopcorn => 'ポップコーンを用意しています';

  @override
  String get loadingPopular => '人気作品を読み込み中';

  @override
  String get callingGirlfriend => '友人に電話しています';

  @override
  String get almostThere => 'もうすぐです...';

  @override
  String get takingLonger => '予想より時間がかかっています :(';

  @override
  String get mainMenu => 'メイン';

  @override
  String get moreOptions => 'その他のオプション';

  @override
  String get counterMenuTitle => 'Riverpodカウンター';

  @override
  String get counterMenuSubtitle => 'Riverpod入門';

  @override
  String get buttonsMenuTitle => 'ボタン';

  @override
  String get buttonsMenuSubtitle => 'Flutterのさまざまなボタン';

  @override
  String get cardsMenuTitle => 'カード';

  @override
  String get cardsMenuSubtitle => 'スタイル付きコンテナ';

  @override
  String get progressMenuTitle => '進行状況インジケーター';

  @override
  String get progressMenuSubtitle => '標準と制御';

  @override
  String get snackbarsMenuTitle => 'スナックバーとダイアログ';

  @override
  String get snackbarsMenuSubtitle => '画面上の通知';

  @override
  String get animatedMenuTitle => 'アニメーションコンテナ';

  @override
  String get animatedMenuSubtitle => 'アニメーション付きステートフルウィジェット';

  @override
  String get controlsMenuTitle => 'UIコントロール';

  @override
  String get controlsMenuSubtitle => 'Flutterコントロールの一覧';

  @override
  String get tutorialMenuTitle => 'アプリの紹介';

  @override
  String get tutorialMenuSubtitle => '短い入門チュートリアル';

  @override
  String get infiniteMenuTitle => '無限スクロール';

  @override
  String get infiniteMenuSubtitle => '無限リストと引き下げ更新';

  @override
  String get themeMenuTitle => 'テーマの変更';

  @override
  String get themeMenuSubtitle => 'アプリのテーマを変更';

  @override
  String get demoHomeTitle => 'Flutter + Material 3';

  @override
  String get buttonsScreenTitle => 'ボタン画面';

  @override
  String get elevatedButton => '浮き出し';

  @override
  String get disabledElevatedButton => '無効な浮き出し';

  @override
  String get elevatedIconButton => 'アイコン付き浮き出し';

  @override
  String get filledButton => '塗りつぶし';

  @override
  String get filledIconButton => 'アイコン付き塗りつぶし';

  @override
  String get outlinedButton => 'アウトライン';

  @override
  String get outlinedIconButton => 'アイコン付きアウトライン';

  @override
  String get textButton => 'テキスト';

  @override
  String get textIconButton => 'アイコン付きテキスト';

  @override
  String get helloWorld => 'こんにちは、世界';

  @override
  String get cardsScreenTitle => 'カード画面';

  @override
  String elevation(int level) {
    return '高さ $level';
  }

  @override
  String outlinedCard(String label) {
    return '$label - アウトライン';
  }

  @override
  String filledCard(String label) {
    return '$label - 塗りつぶし';
  }

  @override
  String get animatedContainerTitle => 'アニメーションコンテナ';

  @override
  String get tutorialExit => '終了';

  @override
  String get tutorialStart => '始める';

  @override
  String get tutorialSearchFoodTitle => '食べ物を探す';

  @override
  String get tutorialSearchFoodCaption => 'お気に入りの料理を簡単に見つけましょう。';

  @override
  String get tutorialFastDeliveryTitle => '迅速な配達';

  @override
  String get tutorialFastDeliveryCaption => 'どこにいても注文を受け取れます。';

  @override
  String get tutorialEnjoyFoodTitle => '食事を楽しむ';

  @override
  String get tutorialEnjoyFoodCaption => 'お気に入りの料理を一口ずつ楽しみましょう。';

  @override
  String get counterScreenTitle => 'カウンター画面';

  @override
  String counterValue(int count) {
    return '値: $count';
  }

  @override
  String get controlsScreenTitle => 'UIコントロール';

  @override
  String get developerMode => '開発者モード';

  @override
  String get additionalControls => '追加のコントロール';

  @override
  String get transportationVehicle => '移動手段';

  @override
  String get byCar => '車で';

  @override
  String get travelByCar => '車で移動';

  @override
  String get byBoat => '船で';

  @override
  String get travelByBoat => '船で移動';

  @override
  String get byPlane => '飛行機で';

  @override
  String get travelByPlane => '飛行機で移動';

  @override
  String get bySubmarine => '潜水艦で';

  @override
  String get travelBySubmarine => '潜水艦で移動';

  @override
  String get breakfast => '朝食？';

  @override
  String get lunch => '昼食？';

  @override
  String get dinner => '夕食？';

  @override
  String get progressScreenTitle => '進行状況インジケーター';

  @override
  String get circularProgress => '円形進行状況インジケーター';

  @override
  String get controlledProgress => '制御された円形・線形インジケーター';

  @override
  String get snackbarsScreenTitle => 'スナックバーとダイアログ';

  @override
  String get ok => 'OK';

  @override
  String get areYouSure => 'よろしいですか？';

  @override
  String get demoDialogMessage => 'これは確認ダイアログのサンプルです。「キャンセル」または「承認」を選ぶと閉じます。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get accept => '承認';

  @override
  String get usedLicenses => '使用ライセンス';

  @override
  String get showDialog => 'ダイアログを表示';

  @override
  String get showSnackbar => 'スナックバーを表示';

  @override
  String get demoAboutMessage => 'このサンプルアプリでは通知、ダイアログ、ライセンス情報を表示します。';

  @override
  String get themeChangerTitle => 'テーマの変更';

  @override
  String get thisColor => 'この色';
}
