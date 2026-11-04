import 'package:flutter/material.dart';

const List<Color> colorList = [
  AppTheme.purple,
  AppTheme.blue,
  AppTheme.lavender,
  Colors.teal,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  static const Color navy = Color(0xFF10132F);
  static const Color surface = Color(0xFF1B1D43);
  static const Color purple = Color(0xFF9875FF);
  static const Color blue = Color(0xFF58B9F7);
  static const Color lavender = Color(0xFFD7CBFF);

  final bool isDarkmode;
  final int selectedColor;

  const AppTheme({this.isDarkmode = true, this.selectedColor = 0});

  AppTheme copyWith({bool? isDarkmode, int? selectedColor}) {
    return AppTheme(
      isDarkmode: isDarkmode ?? this.isDarkmode,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  Color get selectedColorValue => colorList[selectedColor % colorList.length];

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    scaffoldBackgroundColor: isDarkmode ? navy : Colors.white,
    colorScheme: isDarkmode
        ? const ColorScheme.dark(
            primary: purple,
            secondary: blue,
            surface: surface,
            onPrimary: Colors.white,
            onSurface: Colors.white,
          )
        : const ColorScheme.light(
            primary: purple,
            secondary: blue,
            surface: Colors.white,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkmode ? navy : Colors.white,
      foregroundColor: isDarkmode ? Colors.white : Colors.black,
      centerTitle: false,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: isDarkmode ? surface : Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      titleLarge: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
      titleMedium: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
      bodyMedium: TextStyle(color: Color(0xFFE1E2F5)),
      bodySmall: TextStyle(color: Color(0xFFB8B9D5)),
    ),
  );
}
