import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/infrastructure/datasources/cloudinary_video_datasource_impl.dart';
import 'package:toktik/infrastructure/datasources/pexels_video_datasource_impl.dart';
import 'package:toktik/infrastructure/datasources/pixabay_video_datasource_impl.dart';
import 'package:toktik/infrastructure/repositories/video_posts_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/providers/season_provider.dart';
import 'package:toktik/presentation/screens/splash/splash_screen.dart';

import 'package:toktik/infrastructure/datasources/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inicialización del Local Storage para persistencia de favoritos y vistas
  await LocalStorageService.init();

  // Restablecer la preferencia antes de mostrar tema, splash o sonido.
  final seasonProvider = await SeasonProvider.restore();
  runApp(MyApp(seasonProvider: seasonProvider));
}

class MyApp extends StatelessWidget {
  final SeasonProvider seasonProvider;

  const MyApp({super.key, required this.seasonProvider});

  @override
  Widget build(BuildContext context) {
    // 3 APIs diferentes para cada sección de videos:
    // 1. Cloudinary API para "Para ti" (CON SONIDO / AUDIO REAL)
    final forYouRepository = VideoPostsRepositoryImpl(
      videosDatasource: CloudinaryVideoDatasource(),
    );

    // 2. Pixabay API para "Cerca de ti"
    final nearYouRepository = VideoPostsRepositoryImpl(
      videosDatasource: PixabayVideoDatasource(),
    );

    // 3. Pexels API para "Descubrir"
    final discoverRepository = VideoPostsRepositoryImpl(
      videosDatasource: PexelsVideoDatasource(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SeasonProvider>.value(value: seasonProvider),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => DiscoverProvider(
            forYouRepository: forYouRepository,
            nearYouRepository: nearYouRepository,
            discoverRepository: discoverRepository,
          )..loadNextPage(),
        ),
      ],
      child: Consumer<SeasonProvider>(
        builder: (context, seasonState, _) {
          return MaterialApp(
            title: 'TokTik',
            debugShowCheckedModeBanner: false,
            theme: AppTheme(season: seasonState.season).getTheme(),
            home: SplashScreen(season: seasonState.season),
          );
        },
      ),
    );
  }
}
