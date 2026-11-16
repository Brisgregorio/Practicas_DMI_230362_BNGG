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

  ThemeData getTheme() {
    final foreground = isDarkmode ? Colors.white : navy;
    final secondaryForeground = isDarkmode
        ? const Color(0xFFC8C9DE)
        : const Color(0xFF4A4E67);
    final colors = isDarkmode
        ? ColorScheme.dark(
            primary: selectedColorValue,
            secondary: blue,
            surface: surface,
            onPrimary: _contrastForeground(selectedColorValue),
            onSecondary: _contrastForeground(blue),
            onSurface: foreground,
          )
        : ColorScheme.light(
            primary: selectedColorValue,
            secondary: blue,
            surface: Colors.white,
            onPrimary: _contrastForeground(selectedColorValue),
            onSecondary: _contrastForeground(blue),
            onSurface: foreground,
          );
    final baseTextTheme = (isDarkmode
            ? Typography.whiteMountainView
            : Typography.blackMountainView)
        .apply(bodyColor: foreground, displayColor: foreground);
    final textTheme = baseTextTheme.copyWith(
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w800,
        color: foreground,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: foreground,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: foreground,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: foreground),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: secondaryForeground,
      ),
    );
    final surfaceColor = isDarkmode ? surface : Colors.white;
    final accentTextColor = isDarkmode ? selectedColorValue : foreground;

    return ThemeData(
      useMaterial3: true,
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: isDarkmode ? navy : Colors.white,
      colorScheme: colors,
      iconTheme: IconThemeData(color: foreground),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkmode ? navy : Colors.white,
        foregroundColor: foreground,
        centerTitle: false,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      textTheme: textTheme,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: accentTextColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentTextColor,
          side: BorderSide(color: colors.primary),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: accentTextColor,
        unselectedItemColor: secondaryForeground,
      ),
      dividerColor: isDarkmode
          ? const Color(0xFF393B5D)
          : const Color(0xFFD8D9E3),
    );
  }

  static Color _contrastForeground(Color background) =>
      background.computeLuminance() > 0.179 ? Colors.black : Colors.white;
}
