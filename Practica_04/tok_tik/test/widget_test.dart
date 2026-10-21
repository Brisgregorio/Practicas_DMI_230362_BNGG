import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toktik/config/helpers/random_video_metrics.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/config/theme/season_config.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/datasources/local_storage_service.dart';
import 'package:toktik/presentation/providers/season_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.init();
  });

  testWidgets('TokTik theme renders app content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme().getTheme(),
        home: const Scaffold(body: Center(child: Text('TokTik'))),
      ),
    );

    expect(find.text('TokTik'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.text('TokTik'))).brightness,
      Brightness.dark,
    );
  });

  test('RandomVideoMetrics generates < 1000 and likes <= views strictly', () {
    for (int i = 0; i < 200; i++) {
      final metrics = RandomVideoMetrics.generate();
      expect(metrics.views, lessThan(1000), reason: 'Views must be < 1000');
      expect(metrics.likes, lessThan(1000), reason: 'Likes must be < 1000');
      expect(metrics.likes, lessThanOrEqualTo(metrics.views),
          reason: 'A video cannot have more likes than views');
      expect(metrics.likes, greaterThanOrEqualTo(1));
      expect(metrics.views, greaterThanOrEqualTo(60));
    }
  });

  test('VideoPost serializes and deserializes properly', () {
    final original = VideoPost(
      id: 'test_1',
      userName: '@creador_test',
      caption: 'Titulo del video',
      description: 'Esta es una descripcion larga con detalles y #hashtags',
      videoUrl: 'https://test.com/video.mp4',
      likes: 245,
      views: 780,
      isLiked: true,
    );

    final json = original.toJson();
    final reconstructed = VideoPost.fromJson(json);

    expect(reconstructed.id, original.id);
    expect(reconstructed.userName, '@creador_test');
    expect(reconstructed.caption, 'Titulo del video');
    expect(reconstructed.description, original.description);
    expect(reconstructed.videoUrl, original.videoUrl);
    expect(reconstructed.likes, 245);
    expect(reconstructed.views, 780);
    expect(reconstructed.isLiked, true);
  });

  test('selected season persists and restores', () async {
    const iconChannel = MethodChannel('com.example.toktik/app_icon');
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
      iconChannel,
      (call) async => true,
    );

    final seasonProvider = await SeasonProvider.restore();

    try {
      for (final season in AppSeason.values) {
        expect(await seasonProvider.select(season), isTrue);
        final preferences = await SharedPreferences.getInstance();
        expect(
          preferences.getString('toktik_selected_season'),
          season.name,
        );
        expect(season.audioSourcePath,
            'sounds/${season.name == 'normal' ? 'intro' : season.name}.mp3');
      }

      final restoredProvider = await SeasonProvider.restore();
      expect(restoredProvider.season, AppSeason.navidad);
    } finally {
      messenger.setMockMethodCallHandler(iconChannel, null);
    }
  });

  test('video mute preference persists across controllers', () async {
    await LocalStorageService.setVideoMuted(true);

    expect(LocalStorageService.videoMuted.value, isTrue);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool('toktik_video_muted'), isTrue);

    await LocalStorageService.setVideoMuted(false);
  });

  test('LocalStorageService manages favorites and viewed videos', () async {
    final video = VideoPost(
      id: 'v1',
      userName: '@alex',
      caption: 'Video 1',
      videoUrl: 'https://test.com/v1.mp4',
      likes: 100,
      views: 300,
    );

    // Guardar como visto
    await LocalStorageService.saveViewedVideo(video);
    expect(LocalStorageService.isVideoViewed(video.videoUrl), true);

    // Añadir a favoritos
    final liked = await LocalStorageService.toggleFavorite(video);
    expect(liked, true);
    expect(LocalStorageService.isFavorite(video.videoUrl), true);

    final favorites = await LocalStorageService.getFavoriteVideos();
    expect(favorites.length, 1);
    expect(favorites.first.videoUrl, video.videoUrl);
    expect(favorites.first.likes, 100);
    expect(favorites.first.views, 300);

    // Quitar de favoritos
    final unliked = await LocalStorageService.toggleFavorite(video);
    expect(unliked, false);
    expect(LocalStorageService.isFavorite(video.videoUrl), false);

    // Limpiar vistos
    await LocalStorageService.clearViewedVideos();
    expect(LocalStorageService.isVideoViewed(video.videoUrl), false);
  });
}
