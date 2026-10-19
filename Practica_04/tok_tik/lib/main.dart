import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/config/theme/season_config.dart';
import 'package:toktik/infrastructure/datasources/cloudinary_video_datasource_impl.dart';
import 'package:toktik/infrastructure/datasources/pexels_video_datasource_impl.dart';
import 'package:toktik/infrastructure/datasources/pixabay_video_datasource_impl.dart';
import 'package:toktik/infrastructure/repositories/video_posts_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Detección automática de la temporada actual por la fecha del dispositivo
  final currentSeason = SeasonConfig.getSeasonByDate();

  // 2. Sincronización del icono de la app en Android (pantalla de inicio y cajón de apps)
  await SeasonConfig.syncAppIcon(currentSeason);

  runApp(MyApp(season: currentSeason));
}

class MyApp extends StatelessWidget {
  final AppSeason season;

  const MyApp({super.key, this.season = AppSeason.normal});

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
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => DiscoverProvider(
            forYouRepository: forYouRepository,
            nearYouRepository: nearYouRepository,
            discoverRepository: discoverRepository,
          )..loadNextPage(),
        ),
      ],
      child: MaterialApp(
        title: 'TokTik',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(season: season).getTheme(),
        home: SplashScreen(season: season),
      ),
    );
  }
}
