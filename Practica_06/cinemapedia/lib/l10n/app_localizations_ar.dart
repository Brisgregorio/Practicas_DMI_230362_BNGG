// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get discoveryTag => 'اكتشف قصتك القادمة';

  @override
  String get drawerTagline => 'عالمك من الأفلام';

  @override
  String get home => 'الرئيسية';

  @override
  String get nowPlaying => 'تعرض الآن';

  @override
  String get popular => 'الأكثر شعبية';

  @override
  String get topRated => 'الأعلى تقييماً';

  @override
  String get countrySettings => 'بلد الأفلام ولغتها';

  @override
  String get developedBy => 'تطوير بريسا نايلي غارسيا غريغوريو';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get now => 'الآن';

  @override
  String get soon => 'قريباً';

  @override
  String get top => 'الأفضل';

  @override
  String get categories => 'الفئات';

  @override
  String get favorites => 'المفضلة';

  @override
  String get selectorDescription =>
      'يغيّر المنطقة ولغة TMDB والتصنيف المعروض. كما تتغير لغة الواجهة إلى لغة البلد المحدد.';

  @override
  String get classification => 'التصنيف';

  @override
  String get countryMexico => 'المكسيك';

  @override
  String get countryUnitedStates => 'الولايات المتحدة';

  @override
  String get countryBrazil => 'البرازيل';

  @override
  String get countryGermany => 'ألمانيا';

  @override
  String get countryEgypt => 'مصر';

  @override
  String get countryJapan => 'اليابان';

  @override
  String get countryAustralia => 'أستراليا';

  @override
  String get searchMovies => 'ابحث عن أفلام';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get searchFailed => 'تعذر إكمال البحث.';

  @override
  String get noResults => 'لم يتم العثور على أفلام.';

  @override
  String get movieLoadFailed => 'تعذر تحميل الفيلم.';

  @override
  String get castLoadFailed => 'تعذر تحميل طاقم التمثيل.';

  @override
  String get noMoviesFailed => 'تعذر تحميل الأفلام.';

  @override
  String get noMoviesCountry => 'لا تتوفر أفلام لهذا البلد.';

  @override
  String get countryRatingTitle => 'التصنيف حسب البلد';

  @override
  String get atListStart => 'بداية القائمة · الفيلم الأول';

  @override
  String get atListEnd => 'نهاية القائمة · الفيلم الأخير';

  @override
  String get previousMovie => 'الفيلم السابق';

  @override
  String get nextMovie => 'الفيلم التالي';

  @override
  String swipeExplore(int current, int total) {
    return 'اسحب للاستكشاف · $current/$total';
  }

  @override
  String get ratingDisclaimer =>
      '* تصنيف إرشادي. يُرجى مراجعة التصنيف الرسمي المحلي.';

  @override
  String get selectedLanguageTitle => 'العنوان باللغة المحددة';

  @override
  String originalTitleLanguage(String language) {
    return 'العنوان الأصلي ($language)';
  }

  @override
  String originalLanguageAndTitle(String language, String title) {
    return 'الأصلي ($language): $title';
  }

  @override
  String selectedRatingCountry(String country) {
    return 'التصنيف المحدد: $country';
  }

  @override
  String countryItemDetails(String code, String language, String rating) {
    return '$code ($language) · التصنيف: $rating';
  }

  @override
  String get openMenu => 'فتح القائمة';

  @override
  String get pleaseWait => 'يرجى الانتظار';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get loadingMovies => 'جارٍ تحميل الأفلام';

  @override
  String get gettingPopcorn => 'جارٍ إعداد الفشار';

  @override
  String get loadingPopular => 'جارٍ تحميل الأفلام الشائعة';

  @override
  String get callingGirlfriend => 'أتصل بصديقتي';

  @override
  String get almostThere => 'أوشكنا...';

  @override
  String get takingLonger => 'يستغرق الأمر وقتاً أطول من المتوقع :(';

  @override
  String get mainMenu => 'الرئيسية';

  @override
  String get moreOptions => 'المزيد من الخيارات';

  @override
  String get counterMenuTitle => 'عداد Riverpod';

  @override
  String get counterMenuSubtitle => 'مقدمة إلى Riverpod';

  @override
  String get buttonsMenuTitle => 'الأزرار';

  @override
  String get buttonsMenuSubtitle => 'أزرار متنوعة في Flutter';

  @override
  String get cardsMenuTitle => 'البطاقات';

  @override
  String get cardsMenuSubtitle => 'حاوية منسقة';

  @override
  String get progressMenuTitle => 'مؤشرات التقدم';

  @override
  String get progressMenuSubtitle => 'عامة ومتحكم بها';

  @override
  String get snackbarsMenuTitle => 'الإشعارات ومربعات الحوار';

  @override
  String get snackbarsMenuSubtitle => 'مؤشرات على الشاشة';

  @override
  String get animatedMenuTitle => 'حاوية متحركة';

  @override
  String get animatedMenuSubtitle => 'عنصر واجهة بحالة متحركة';

  @override
  String get controlsMenuTitle => 'عناصر التحكم';

  @override
  String get controlsMenuSubtitle => 'مجموعة من عناصر Flutter';

  @override
  String get tutorialMenuTitle => 'مقدمة التطبيق';

  @override
  String get tutorialMenuSubtitle => 'دليل تمهيدي قصير';

  @override
  String get infiniteMenuTitle => 'تمرير لا نهائي';

  @override
  String get infiniteMenuSubtitle => 'قوائم لا نهائية والتحديث بالسحب';

  @override
  String get themeMenuTitle => 'تغيير المظهر';

  @override
  String get themeMenuSubtitle => 'تغيير مظهر التطبيق';

  @override
  String get demoHomeTitle => 'Flutter + Material 3';

  @override
  String get buttonsScreenTitle => 'شاشة الأزرار';

  @override
  String get elevatedButton => 'بارز';

  @override
  String get disabledElevatedButton => 'بارز معطل';

  @override
  String get elevatedIconButton => 'بارز مع أيقونة';

  @override
  String get filledButton => 'ممتلئ';

  @override
  String get filledIconButton => 'ممتلئ مع أيقونة';

  @override
  String get outlinedButton => 'محدد';

  @override
  String get outlinedIconButton => 'محدد مع أيقونة';

  @override
  String get textButton => 'نص';

  @override
  String get textIconButton => 'نص مع أيقونة';

  @override
  String get helloWorld => 'مرحباً بالعالم';

  @override
  String get cardsScreenTitle => 'شاشة البطاقات';

  @override
  String elevation(int level) {
    return 'الارتفاع $level';
  }

  @override
  String outlinedCard(String label) {
    return '$label - محدد';
  }

  @override
  String filledCard(String label) {
    return '$label - ممتلئ';
  }

  @override
  String get animatedContainerTitle => 'حاوية متحركة';

  @override
  String get tutorialExit => 'خروج';

  @override
  String get tutorialStart => 'ابدأ';

  @override
  String get tutorialSearchFoodTitle => 'ابحث عن طعامك';

  @override
  String get tutorialSearchFoodCaption => 'اعثر بسهولة على أطباقك المفضلة.';

  @override
  String get tutorialFastDeliveryTitle => 'توصيل سريع';

  @override
  String get tutorialFastDeliveryCaption => 'استلم طلبك أينما كنت.';

  @override
  String get tutorialEnjoyFoodTitle => 'استمتع بطعامك';

  @override
  String get tutorialEnjoyFoodCaption => 'استمتع بكل لقمة من أطباقك المفضلة.';

  @override
  String get counterScreenTitle => 'شاشة العداد';

  @override
  String counterValue(int count) {
    return 'القيمة: $count';
  }

  @override
  String get controlsScreenTitle => 'عناصر التحكم';

  @override
  String get developerMode => 'وضع المطور';

  @override
  String get additionalControls => 'عناصر تحكم إضافية';

  @override
  String get transportationVehicle => 'وسيلة النقل';

  @override
  String get byCar => 'بالسيارة';

  @override
  String get travelByCar => 'السفر بالسيارة';

  @override
  String get byBoat => 'بالقارب';

  @override
  String get travelByBoat => 'السفر بالقارب';

  @override
  String get byPlane => 'بالطائرة';

  @override
  String get travelByPlane => 'السفر بالطائرة';

  @override
  String get bySubmarine => 'بالغواصة';

  @override
  String get travelBySubmarine => 'السفر بالغواصة';

  @override
  String get breakfast => 'الإفطار؟';

  @override
  String get lunch => 'الغداء؟';

  @override
  String get dinner => 'العشاء؟';

  @override
  String get progressScreenTitle => 'مؤشرات التقدم';

  @override
  String get circularProgress => 'مؤشر تقدم دائري';

  @override
  String get controlledProgress => 'مؤشرا تقدم دائري وخطي متحكّم بهما';

  @override
  String get snackbarsScreenTitle => 'الإشعارات ومربعات الحوار';

  @override
  String get ok => 'حسناً';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String get demoDialogMessage =>
      'هذا مربع حوار تأكيد تجريبي. اختر إلغاء أو موافق لإغلاقه.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get accept => 'موافق';

  @override
  String get usedLicenses => 'التراخيص المستخدمة';

  @override
  String get showDialog => 'عرض مربع الحوار';

  @override
  String get showSnackbar => 'عرض الإشعار';

  @override
  String get demoAboutMessage =>
      'يعرض هذا التطبيق التجريبي الإشعارات ومربعات الحوار ومعلومات التراخيص.';

  @override
  String get themeChangerTitle => 'تغيير المظهر';

  @override
  String get thisColor => 'هذا اللون';
}
