// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get discoveryTag => '发现你的下一段故事';

  @override
  String get drawerTagline => '你的电影天地';

  @override
  String get home => '首页';

  @override
  String get nowPlaying => '正在上映';

  @override
  String get popular => '热门';

  @override
  String get topRated => '高分影片';

  @override
  String get countrySettings => '影片国家和语言';

  @override
  String get developedBy => '开发者：Brisa Nallely Garcia Gregorio';

  @override
  String get comingSoon => '即将上映';

  @override
  String get now => '现在';

  @override
  String get soon => '即将上映';

  @override
  String get top => '高分';

  @override
  String get categories => '分类';

  @override
  String get favorites => '收藏';

  @override
  String get addToFavorites => '添加到收藏';

  @override
  String get removeFromFavorites => '从收藏中移除';

  @override
  String get noFavoriteMovies => '还没有收藏的电影。';

  @override
  String get favoritesLoadFailed => '无法加载收藏的电影。';

  @override
  String get selectGenre => '选择一个类型以查看相关电影。';

  @override
  String get genresLoadFailed => '无法加载电影类型。';

  @override
  String get genreMoviesLoadFailed => '无法加载此类型的电影。';

  @override
  String get noMoviesForGenre => '此类型暂无电影。';

  @override
  String get series => '剧集';

  @override
  String get popularSeries => '热门剧集';

  @override
  String get seriesLoadFailed => '无法加载热门剧集。';

  @override
  String get seriesDetailsLoadFailed => '无法加载剧集详情。';

  @override
  String get tvSeriesOverviewUnavailable => '暂无简介。';

  @override
  String tvSeriesVotes(int count) {
    return '$count 个评分';
  }

  @override
  String get tvSeriesGenres => '类型';

  @override
  String get tvSeriesFirstAirDate => '首播日期';

  @override
  String get tvSeriesLastAirDate => '末播日期';

  @override
  String get tvSeriesStatus => '播出状态';

  @override
  String get tvSeriesSeasons => '季数';

  @override
  String get tvSeriesEpisodes => '集数';

  @override
  String get tvSeriesCreators => '创作者';

  @override
  String get tvSeriesProductionCompanies => '制作公司';

  @override
  String get tvSeriesNetworks => '电视台';

  @override
  String get noPopularSeries => '暂无热门剧集。';

  @override
  String get noFavorites => '还没有收藏内容。';

  @override
  String get rankingTitle => '排行榜';

  @override
  String get demoDataLabel => '演示数据';

  @override
  String get demoDataDescription => '资料和积分均为虚构示例，并不代表真实用户或成绩。';

  @override
  String demoProfile(int number) {
    return '示例资料 $number';
  }

  @override
  String demoPoints(int points) {
    return '$points 积分';
  }

  @override
  String get selectorDescription => '国家设置决定 TMDB 的地区、语言和分级；界面语言可以单独选择。';

  @override
  String get interfaceLanguage => '界面语言';

  @override
  String get followCountryLanguage => '跟随国家语言';

  @override
  String get classification => '分级';

  @override
  String get countryMexico => '墨西哥';

  @override
  String get countryUnitedStates => '美国';

  @override
  String get countryBrazil => '巴西';

  @override
  String get countryGermany => '德国';

  @override
  String get countryEgypt => '埃及';

  @override
  String get countryJapan => '日本';

  @override
  String get countryAustralia => '澳大利亚';

  @override
  String get searchMovies => '搜索电影';

  @override
  String get searchTvSeries => '搜索电视剧';

  @override
  String get searchTvSeriesHint => '输入电视剧名称进行搜索。';

  @override
  String get noTvSeriesResults => '未找到电视剧。';

  @override
  String get tvSeriesSearchFailed => '电视剧搜索失败。';

  @override
  String get clearTvSeriesSearch => '清除搜索';

  @override
  String get retry => '重试';

  @override
  String get searchFailed => '搜索失败。';

  @override
  String get noResults => '没有找到电影。';

  @override
  String get movieLoadFailed => '无法加载电影。';

  @override
  String get castLoadFailed => '无法加载演职人员。';

  @override
  String get castTitle => '演职人员';

  @override
  String get castEmpty => '暂无演职人员信息。';

  @override
  String get noMoviesFailed => '无法加载电影。';

  @override
  String get noMoviesCountry => '该国家暂无可用电影。';

  @override
  String get countryRatingTitle => '国家分级';

  @override
  String get atListStart => '列表开头 · 第一部电影';

  @override
  String get atListEnd => '列表末尾 · 最后一部电影';

  @override
  String get previousMovie => '上一部电影';

  @override
  String get nextMovie => '下一部电影';

  @override
  String swipeExplore(int current, int total) {
    return '滑动浏览 · $current/$total';
  }

  @override
  String get ratingDisclaimer => '* 此处仅供参考，请查询当地官方分级。';

  @override
  String get selectedLanguageTitle => '所选语言的标题';

  @override
  String originalTitleLanguage(String language) {
    return '原名（$language）';
  }

  @override
  String originalLanguageAndTitle(String language, String title) {
    return '原文（$language）：$title';
  }

  @override
  String selectedRatingCountry(String country) {
    return '所选分级：$country';
  }

  @override
  String countryItemDetails(String code, String language, String rating) {
    return '$code（$language）· 分级：$rating';
  }

  @override
  String get openMenu => '打开菜单';

  @override
  String get pleaseWait => '准备好，精彩内容即将开始！';

  @override
  String get loading => '正在寻找遥控器……';

  @override
  String get loadingMovies => '正在邀请电影登场……';

  @override
  String get gettingPopcorn => '正在准备爆米花……';

  @override
  String get loadingPopular => '正在联系明星……';

  @override
  String get callingGirlfriend => '请导演稍等一下……';

  @override
  String get almostThere => '预告片马上开始！';

  @override
  String get takingLonger => '电影还需要一点时间……';

  @override
  String get mainMenu => '主页';

  @override
  String get moreOptions => '更多选项';

  @override
  String get counterMenuTitle => 'Riverpod 计数器';

  @override
  String get counterMenuSubtitle => 'Riverpod 入门';

  @override
  String get buttonsMenuTitle => '按钮';

  @override
  String get buttonsMenuSubtitle => 'Flutter 中的各种按钮';

  @override
  String get cardsMenuTitle => '卡片';

  @override
  String get cardsMenuSubtitle => '带样式的容器';

  @override
  String get progressMenuTitle => '进度指示器';

  @override
  String get progressMenuSubtitle => '基础与可控进度';

  @override
  String get snackbarsMenuTitle => '提示栏和对话框';

  @override
  String get snackbarsMenuSubtitle => '屏幕提示组件';

  @override
  String get animatedMenuTitle => '动画容器';

  @override
  String get animatedMenuSubtitle => '动画效果示例';

  @override
  String get controlsMenuTitle => '界面控件和列表项';

  @override
  String get controlsMenuSubtitle => 'Flutter 控件集合';

  @override
  String get tutorialMenuTitle => '应用介绍';

  @override
  String get tutorialMenuSubtitle => '简短的入门介绍';

  @override
  String get infiniteMenuTitle => '无限滚动';

  @override
  String get infiniteMenuSubtitle => '无限列表和下拉刷新';

  @override
  String get themeMenuTitle => '更改主题';

  @override
  String get themeMenuSubtitle => '更改应用外观';

  @override
  String get demoHomeTitle => 'Flutter + Material 3';

  @override
  String get buttonsScreenTitle => '按钮页面';

  @override
  String get elevatedButton => '立体按钮';

  @override
  String get disabledElevatedButton => '禁用的立体按钮';

  @override
  String get elevatedIconButton => '带图标的立体按钮';

  @override
  String get filledButton => '填充按钮';

  @override
  String get filledIconButton => '带图标的填充按钮';

  @override
  String get outlinedButton => '描边按钮';

  @override
  String get outlinedIconButton => '带图标的描边按钮';

  @override
  String get textButton => '文本按钮';

  @override
  String get textIconButton => '带图标的文本按钮';

  @override
  String get helloWorld => '你好，世界';

  @override
  String get cardsScreenTitle => '卡片页面';

  @override
  String elevation(int level) {
    return '高度 $level';
  }

  @override
  String outlinedCard(String label) {
    return '$label - 描边';
  }

  @override
  String filledCard(String label) {
    return '$label - 填充';
  }

  @override
  String get animatedContainerTitle => '动画容器';

  @override
  String get tutorialExit => '退出';

  @override
  String get tutorialStart => '开始使用';

  @override
  String get tutorialSearchFoodTitle => '寻找美食';

  @override
  String get tutorialSearchFoodCaption => '轻松找到你喜欢的菜品。';

  @override
  String get tutorialFastDeliveryTitle => '快速配送';

  @override
  String get tutorialFastDeliveryCaption => '把订单送到你所在的地方。';

  @override
  String get tutorialEnjoyFoodTitle => '享受美食';

  @override
  String get tutorialEnjoyFoodCaption => '享受每一口美味。';

  @override
  String get counterScreenTitle => '计数器页面';

  @override
  String counterValue(int count) {
    return '数值：$count';
  }

  @override
  String get controlsScreenTitle => '界面控件';

  @override
  String get developerMode => '开发者模式';

  @override
  String get additionalControls => '其他控件';

  @override
  String get transportationVehicle => '交通工具';

  @override
  String get byCar => '开车';

  @override
  String get travelByCar => '乘车出行';

  @override
  String get byBoat => '乘船';

  @override
  String get travelByBoat => '乘船出行';

  @override
  String get byPlane => '乘飞机';

  @override
  String get travelByPlane => '乘飞机出行';

  @override
  String get bySubmarine => '乘潜水艇';

  @override
  String get travelBySubmarine => '乘潜水艇出行';

  @override
  String get breakfast => '吃早餐吗？';

  @override
  String get lunch => '吃午餐吗？';

  @override
  String get dinner => '吃晚餐吗？';

  @override
  String get progressScreenTitle => '进度指示器';

  @override
  String get circularProgress => '圆形进度指示器';

  @override
  String get controlledProgress => '可控的圆形和线性进度指示器';

  @override
  String get snackbarsScreenTitle => '提示栏和对话框';

  @override
  String get ok => '确定';

  @override
  String get areYouSure => '确定吗？';

  @override
  String get demoDialogMessage => '这是一个示例确认对话框。选择取消或确认以关闭。';

  @override
  String get cancel => '取消';

  @override
  String get accept => '确认';

  @override
  String get usedLicenses => '使用的许可证';

  @override
  String get showDialog => '显示对话框';

  @override
  String get showSnackbar => '显示提示栏';

  @override
  String get demoAboutMessage => '此示例应用展示通知、对话框和许可证信息。';

  @override
  String get themeChangerTitle => '更改主题';

  @override
  String get thisColor => '此颜色';

  @override
  String get tvSeriesGenreResultsLoadFailed => '无法加载此类型的剧集。';

  @override
  String get all => '全部';

  @override
  String get noTvSeriesForGenre => '此类型暂无剧集。';

  @override
  String get tvSeriesGenresLoadFailed => '无法加载剧集类型。';

  @override
  String get movies => '电影';
}
