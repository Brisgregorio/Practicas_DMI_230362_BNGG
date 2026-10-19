import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/config/theme/season_config.dart';
import 'package:toktik/infrastructure/datasources/local_video_datasource_impl.dart';
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
    final videoPostRepository = VideoPostsRepositoryImpl(
      videosDatasource: LocalVideoDatasource(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => DiscoverProvider(videosRepositoy: videoPostRepository)..loadNextPage(),
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
