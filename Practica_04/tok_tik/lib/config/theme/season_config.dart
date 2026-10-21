import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppSeason {
  normal,
  valentine,
  halloween,
  navidad;

  String get displayName {
    switch (this) {
      case AppSeason.normal:
        return 'Normal';
      case AppSeason.valentine:
        return 'San Valentín';
      case AppSeason.halloween:
        return 'Halloween';
      case AppSeason.navidad:
        return 'Navidad';
    }
  }

  String get logoAsset {
    switch (this) {
      case AppSeason.normal:
        return 'assets/images/logo.jpeg';
      case AppSeason.valentine:
        return 'assets/images/logo_valentine.jpeg';
      case AppSeason.halloween:
        return 'assets/images/logo_halloween.jpeg';
      case AppSeason.navidad:
        return 'assets/images/logo_navidad.jpeg';
    }
  }

  /// Path relativo a la carpeta assets/ para AudioPlayer (AssetSource)
  String get audioSourcePath {
    switch (this) {
      case AppSeason.normal:
        return 'sounds/intro.mp3';
      case AppSeason.valentine:
        return 'sounds/valentine.mp3';
      case AppSeason.halloween:
        return 'sounds/halloween.mp3';
      case AppSeason.navidad:
        return 'sounds/navidad.mp3';
    }
  }

  Color get accentColor {
    switch (this) {
      case AppSeason.normal:
        return const Color(0xFF6C5CE7);
      case AppSeason.valentine:
        return const Color(0xFFFF4B72);
      case AppSeason.halloween:
        return const Color(0xFFFF793F);
      case AppSeason.navidad:
        return const Color(0xFF2ED573);
    }
  }

  String get welcomeGreeting {
    switch (this) {
      case AppSeason.normal:
        return '¡Bienvenido a TokTik!';
      case AppSeason.valentine:
        return '¡Feliz San Valentín en TokTik!';
      case AppSeason.halloween:
        return '¡Feliz Halloween en TokTik!';
      case AppSeason.navidad:
        return '¡Feliz Navidad en TokTik!';
    }
  }
}

class SeasonConfig {
  static const MethodChannel _channel =
      MethodChannel('com.example.toktik/app_icon');

  /// Determina la temporada automáticamente con base en la fecha del dispositivo
  static AppSeason getSeasonByDate([DateTime? date]) {
    final now = date ?? DateTime.now();
    final month = now.month;
    final day = now.day;

    // Febrero -> San Valentín
    if (month == 2) {
      return AppSeason.valentine;
    }

    // Octubre o primeros días de noviembre -> Halloween
    if (month == 10 || (month == 11 && day <= 3)) {
      return AppSeason.halloween;
    }

    // Diciembre o primera semana de enero -> Navidad
    if (month == 12 || (month == 1 && day <= 6)) {
      return AppSeason.navidad;
    }

    // Resto del año -> Normal
    return AppSeason.normal;
  }

  /// Sincroniza el icono nativo de Android sin interrumpir la ejecución en primer plano
  static Future<bool> syncAppIcon(AppSeason season) async {
    try {
      return await _channel.invokeMethod<bool>('changeIcon', {
            'season': season.name,
          }) ??
          false;
    } catch (e) {
      debugPrint('No se pudo cambiar el icono nativo: $e');
      return false;
    }
  }
}
