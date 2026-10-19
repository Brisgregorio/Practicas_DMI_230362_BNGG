import 'package:flutter/material.dart';
import 'package:toktik/config/theme/season_config.dart';

class AppTheme {
  final AppSeason season;

  AppTheme({this.season = AppSeason.normal});

  ThemeData getTheme([AppSeason? customSeason]) {
    final activeSeason = customSeason ?? season;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: activeSeason.accentColor,
      scaffoldBackgroundColor: Colors.black,
    );
  }
}
