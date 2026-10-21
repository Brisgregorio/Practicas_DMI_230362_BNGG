import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toktik/config/theme/season_config.dart';

/// Single source of truth for the selected season across UI, storage and icon.
class SeasonProvider extends ChangeNotifier {
  static const _preferenceKey = 'toktik_selected_season';

  AppSeason _season;
  AppSeason get season => _season;

  SeasonProvider._(this._season);

  static Future<SeasonProvider> restore() async {
    final preferences = await SharedPreferences.getInstance();
    final storedName = preferences.getString(_preferenceKey);
    final restoredSeason = AppSeason.values.firstWhere(
      (value) => value.name == storedName,
      orElse: SeasonConfig.getSeasonByDate,
    );
    if (storedName == null ||
        !AppSeason.values.any((value) => value.name == storedName)) {
      await preferences.setString(_preferenceKey, restoredSeason.name);
    }

    final provider = SeasonProvider._(restoredSeason);
    await provider.syncIcon();
    return provider;
  }

  Future<bool> select(AppSeason season) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_preferenceKey, season.name);
    if (_season != season) {
      _season = season;
      notifyListeners();
    }
    return syncIcon();
  }

  Future<bool> syncIcon() => SeasonConfig.syncAppIcon(_season);
}
